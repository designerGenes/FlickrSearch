//
//  AppDelegate.h
//  designerJeans_Flickr
//
//  Created by Jaden Nation on 5/9/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property dispatch_queue_t GlobalMainQueue;
@property dispatch_queue_t GlobalBackgroundQueue;


+(AppDelegate *)getAppDelegate;
+ (NSTimer *)scheduleRepeatingEvent:(double)repeatInterval :(void (^) (CFRunLoopTimerRef)) handler;
@end

