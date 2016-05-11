//
//  FlickrPhoto.h
//  designerJeans_Flickr
//
//  Created by Jaden Nation on 5/10/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhoto : NSObject
  @property (nonatomic, strong) NSURL *photoURL;
  @property (nonatomic, strong) NSString *photoOwner;
  @property (nonatomic, strong) NSString *photoTakenDate;

@end
