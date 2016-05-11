//
//  BaseViewController_Model.m
//  designerJeans_Flickr
//
//  Created by Jaden Nation on 5/9/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "BaseVC_model.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FlickrKit/FlickrKit.h"
#import "FlickrPhoto.h"
#import "DateTools.h"

@implementation BaseVC_model {
  BaseViewController *master;
//  NSMutableArray *dataArray;
//  NSMutableArray *photoURLs;
  NSMutableArray *requestOptions;
  
  // hacky properties
  NSMutableString *nsid;
  NSMutableString *iconfarm;
  NSMutableString *iconserver;
  
}
# pragma mark -  variables
  NSString *perPage = @"50";


-(void)getUserDetailsFor :(NSString *)username :(void (^)(NSMutableArray*)) CompletionBlock  {
  __block NSMutableArray *userData = [[NSMutableArray alloc] init];
  // http://farm{icon-farm}.staticflickr.com/{icon-server}/buddyicons/{nsid}.jpg
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
  
  
    FKFlickrPeopleFindByUsername *request = [[FKFlickrPeopleFindByUsername alloc] init];
    FKFlickrPeopleGetInfo *nextRequest = [[FKFlickrPeopleGetInfo alloc] init ];
  
    [request setUsername:username];
    [fk call:request completion:^(NSDictionary *response, NSError *error) {
      if (response) {
        NSLog(@"first response recieved");
        nsid =  [response valueForKeyPath:(@"user.nsid")];  // NSID
        [userData addObject:nsid];
        [nextRequest setUser_id:nsid];
        [fk call:nextRequest completion:^(NSDictionary *response, NSError *error) {
        
        if (response) {
          NSLog(@"second response recieved");
          iconfarm = [response valueForKeyPath:(@"person.iconfarm") ];
          iconserver = [response valueForKeyPath:(@"person.iconserver")];
          [userData addObject:iconfarm];
          [userData addObject:iconserver];
          CompletionBlock(userData);
          
 
        } else if (error) {
          NSLog(@"error");
        }
    }];
      }}];
  
}


-(UIImage *)getBuddyIconWith :(NSArray *)userDetails{
  // icon-server
  // icon-farm
  // nsid
  
  
  FlickrKit *fk = [FlickrKit sharedFlickrKit];
  NSString *fullURL = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/buddyicons/%@.jpg", userDetails[2], userDetails[1], userDetails[0]];
  UIImage *buddyImage = [[UIImage alloc] init];
  NSDictionary *requestArgs = [[NSDictionary alloc] init];
  
  NSLog(@"%@", fullURL);
  
  [fk call:fullURL args:requestArgs completion:^(NSDictionary *response, NSError *error) {
    if (response) {
      
    }
  }];
  
  
  
  return buddyImage;
}

-(void)handlePreRequestSteps { // if needed
  
}

-(void)requestPhotosOfTag :(NSString*)tag :(NSDate*)minDate :(NSDate*)maxDate {
  FKFlickrPhotosSearch *request = [[FKFlickrPhotosSearch alloc] init];
  if (tag) { [request setTags:tag]; }
  [request setExtras:@"owner_name, date_upload"];
  
  if (minDate) [request setMin_taken_date: [NSDate timeAgoSinceDate:minDate]];
  if (maxDate) [request setMax_taken_date: [NSDate timeAgoSinceDate:maxDate]];
  [self handleRequest:request];
  
}

-(void)handleRequest :(NSObject<FKFlickrAPIMethod>*)request {
  [self setCurrentRequest:request];
  
  FlickrKit *fk = [FlickrKit sharedFlickrKit];
  [fk call:request completion:^(NSDictionary *response, NSError *error) {
    if (response) {
      NSLog(@"got a response!");
      
      NSMutableArray *photos = [NSMutableArray array];
      
      for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
        FlickrPhoto *newPhoto = [[FlickrPhoto alloc] init];
        newPhoto.photoURL = [fk photoURLForSize:FKPhotoSizeMedium640 fromPhotoDictionary:photoData];
        newPhoto.photoOwner = [photoData valueForKey:@"ownername"];
        newPhoto.photoTakenDate = [photoData valueForKey:@"dateupload"];
        [photos addObject:newPhoto];
      }
      
      dispatch_async(dispatch_get_main_queue(), ^{
        [master reloadTable:photos];
      });
      
    }
  }];
}

-(void)requestPhotosOfRecent  {
  FKFlickrInterestingnessGetList *request = [[FKFlickrInterestingnessGetList alloc] init];
  
  [request setExtras:@"owner_name, date_upload"];
//  NSDate *today = [NSDate date];
//  NSDate *thePast = [today dateBySubtractingMonths:1];
//  [NSDate since]
//    [request setDate:[today timeAgoSinceNow]];
//  [request setMin_date:[thePast timeAgoSinceDate:today]];
//  [request setMin_date:[NSDate timeAgoSinceDate:[]]
  
  [self handleRequest:request];
  
}

-(void)sendRequest_Interesting{
  FlickrKit *fk = [FlickrKit sharedFlickrKit];
    FKFlickrInterestingnessGetList *request = [[FKFlickrInterestingnessGetList alloc] init ];
    [request setExtras:@"owner_name, date_upload"];
    [request setPer_page:perPage];
  
  
  [fk call:request completion:^(NSDictionary *response, NSError *error) {
    
    if (response) {
      
      
       NSMutableArray *photoURLs = [NSMutableArray array];
//      [self.photoOwners removeAllObjects];
//      [self.datesUploaded removeAllObjects];
//      [self.gatheredPhotosArray removeAllObjects];
      
      self.photoOwners = [response valueForKeyPath:@"photos.photo.ownername"];
      self.photoDates = [response valueForKeyPath:@"photos.photo.dateupload"];
      
    
      for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
      
        NSURL *url = [fk photoURLForSize:FKPhotoSizeMedium640 fromPhotoDictionary:photoData];
        [photoURLs addObject:url];

      }
      dispatch_async(dispatch_get_main_queue(), ^{
        
        [self loadPhotosIntoMemory:photoURLs];
      });
    }
  }];
}



# pragma mark -  custom methods





-(BaseViewController *)getMaster {
  return master;
}

-(NSMutableArray *)getGatheredPhotos {
  return self.gatheredPhotos;
}

-(NSMutableArray *)getPhotoDates {
  return self.photoDates;
}

-(NSMutableArray *)getPhotoOwners {
  return self.photoOwners;
}

-(void)loadPhotosIntoMemory: (NSArray *)listOfURLs {
  NSLog(@"loading photos to memory");
  NSMutableArray *list = listOfURLs.mutableCopy;
  if (list.count > 0) {
    if (list.count > 50) {
      list = (NSMutableArray*)[list subarrayWithRange:NSMakeRange(0, 50)];
    }
    dispatch_queue_t bgQ = [AppDelegate getAppDelegate].GlobalBackgroundQueue;
    dispatch_async(bgQ, ^{
      for (NSURL *url in list) {
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        [self.gatheredPhotos addObject:image];
        if (self.gatheredPhotos.count == 25) {
          dispatch_async(dispatch_get_main_queue(), ^{
            [master beginUpdatingTableView];  // start filling in
          });
        }
      }
    });
    
  }
}


-(id)initWithMaster: (BaseViewController *)setMaster {
  master = setMaster;
//  dataArray = [[NSMutableArray alloc] init];
//  photoURLs = [[NSMutableArray alloc] init];
//  self.gatheredPhotos = [[NSMutableArray alloc] init];
//  [master reloadTable];
  
  
  
//  requestOptions = @[option_GetInteresting, option_GetRecent];

  
  self = [super init];
  return self;
}


@end
