//
//  AppDelegate.m
//  Example
//
//  Created by Samuel Cote on 2016-12-15.
//  Copyright © 2016 DialogInsight. All rights reserved.
//

#import "AppDelegate.h"
#import "DIAnalyticsViewController.h"
#import <DIAnalytics/DIAnalytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    DIAnalyticsViewController* homeVC = [[DIAnalyticsViewController alloc] init];
    UINavigationController* homeNC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = homeNC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.tintColor= [UIColor blackColor];
    
    [[[DIAnalytics setLogEnabled:YES] setBaseUrl:@"https://ofsys.com"] startWithApplicationId:@"43:3eKDDFH09wnUmFURCkL2hf5l62i3BbAu" withLaunchOptions:launchOptions];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Notification delegate

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [DIAnalytics handleDidReceiveRemoteNotification:userInfo];
    
    if (application.applicationState == UIApplicationStateActive ) {
        NSLog(@"Application is in foreground when receive notificaiton, application should handle display of notification.");
    }
}

//For iOS under 10, you must implement this two methode to registe for token
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [DIAnalytics handleDidRegisterForRemoteNotificationWithDeviceToken:deviceToken];
}


@end
