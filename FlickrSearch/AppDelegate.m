//
//  AppDelegate.m
//  designerJeans_Flickr
//
//  Created by Jaden Nation on 5/9/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

#import "AppDelegate.h"
#import "FlickrKit/FlickrKit.h"



//return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)


@interface AppDelegate ()

@end

@implementation AppDelegate

//dispatch_queue_t myConst = dispatch_get_global_queue(enum QOS_CLASS_BACKGROUND, <#unsigned long flags#>)
//dispatch_get_global_queue(int(QOS_CLASS_BACKGROUND.rawValue), 0);

  

+(AppDelegate *)getAppDelegate {
  return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  NSString *apiKey = @"01c59a3705fe96b515fb9de5ccd09ea7";
  NSString *sharedSecret = @"623e8f0564f24411";
  self.GlobalBackgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
  [[FlickrKit sharedFlickrKit] initializeWithAPIKey:apiKey sharedSecret:sharedSecret];
  
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (NSTimer *)scheduleRepeatingEvent:(double)repeatInterval :(void (^) (CFRunLoopTimerRef)) handler {
  double fireDate = repeatInterval + CFAbsoluteTimeGetCurrent();
  CFRunLoopTimerRef timer =  CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, repeatInterval, 0, 0, handler);
  CFRunLoopRef myRef = CFRunLoopGetCurrent();
  CFRunLoopAddTimer(myRef, timer, kCFRunLoopCommonModes);
  return (__bridge NSTimer *)(timer);
}

+ (NSTimer *)scheduleEvent:(double)delay :(void (^) (CFRunLoopTimerRef)) handler {
  double fireDate = delay + CFAbsoluteTimeGetCurrent();
  CFRunLoopTimerRef timer =  CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, delay, 0, 0, handler);
  CFRunLoopRef myRef = CFRunLoopGetCurrent();
  CFRunLoopAddTimer(myRef, timer, kCFRunLoopCommonModes);
  return (__bridge NSTimer *)(timer);
}

@end
