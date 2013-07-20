//
//  uhkAppDelegate.m
//  SmartHomePoint
//
//  Created by Jarda on 7/16/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "uhkAppDelegate.h"


@implementation uhkAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // load user settings
    NSString* path = [self getDataFile];
    BOOL firstTimeLaunch = ![[NSFileManager defaultManager] fileExistsAtPath:path];
    if (!firstTimeLaunch) {
        //NSArray *values = [[NSArray alloc] initWithContentsOfFile:path];
    }
    
    // select storyboard and initial viewController
    UIStoryboard *storyBoard = nil;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        if (firstTimeLaunch)
            storyBoard = [UIStoryboard storyboardWithName:@"SettingsStoryboard_iPad" bundle:nil];
    }else{
        //CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        //if (iOSDeviceScreenSize.height == 480) or if (iOSDeviceScreenSize.height == 568)
        storyBoard = [UIStoryboard storyboardWithName:@"SettingsStoryboard_iPhone" bundle:nil];
    }

    if (storyBoard!=NULL) {
        UIViewController * controller = [storyBoard instantiateInitialViewController];
        self.window.rootViewController = controller;
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSString*) getDataFile
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"savefile.plist"];
}



@end
