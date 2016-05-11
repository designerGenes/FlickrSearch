//
//  BaseViewController_model.h
//  designerJeans_Flickr
//
//  Created by Jaden Nation on 5/9/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "FlickrKit/FlickrKit.h"
#import <UIKit/UIKit.h>





@interface BaseVC_model : NSObject

# pragma mark -  variables
 

@property (nonatomic, strong) NSMutableArray *photoOwners;
@property (nonatomic, strong) NSMutableArray *photoDates;
@property (nonatomic, strong) NSMutableArray *gatheredPhotos;

@property (nonatomic, strong) NSObject<FKFlickrAPIMethod>* currentRequest;

//-(void)requestBuddyIcon :(NSString*)NSID :(NSString*)icon_server :(NSString*)icon_farm;
-(void)requestMoreUserInfoAbout :(NSMutableArray *)people;
-(void)requestPhotosOfTag :(NSString*)tag :(NSDate*)minDate :(NSDate*)maxDate;
-(void)requestPhotosOfRecent;

# pragma mark -  custom methods
- (id)initWithMaster:(UIViewController *)setMaster;
- (void)sendRequest_Interesting;

//- (NSMutableArray *)getDataArray;
- (NSMutableArray *)getGatheredPhotos;
- (NSMutableArray *)getPhotoDates;
- (NSMutableArray *)getPhotoOwners;
- (UIViewController *)getMaster;



-(void)getUserDetailsFor :(NSString *)username :(void (^)(NSMutableArray*))CompletionBlock;
-(UIImage *)getBuddyIconWith :(NSArray *)userDetails;
-(void)handleRequest :(NSObject<FKFlickrAPIMethod>*)request;
@end

