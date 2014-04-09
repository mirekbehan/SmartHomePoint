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
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // system settings
    NSString *resetTokenKey = @"reset_token";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults==NULL)
        NSLog(@"The settings does not exists!");
    BOOL resetToken = (BOOL)[defaults valueForKey:resetTokenKey];
    if (resetToken)
        [defaults setObject:NO forKey:resetTokenKey];

    // user settings and data
    NSString* path = [self getDataFile];
    BOOL firstTimeLaunch = ![[NSFileManager defaultManager] fileExistsAtPath:path];
    if (!firstTimeLaunch) {
        //NSArray *values = [[NSArray alloc] initWithContentsOfFile:path];
    }
    
    // select storyboard and initial viewController
    if (resetToken || firstTimeLaunch) {
        UIStoryboard *storyBoard = nil;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
            storyBoard = [UIStoryboard storyboardWithName:@"SettingsStoryboard_iPad" bundle:nil];
        else
            storyBoard = [UIStoryboard storyboardWithName:@"SettingsStoryboard_iPhone" bundle:nil];
        if (storyBoard==NULL)
            NSLog(@"storyboard is null");
        UIViewController * controller = [storyBoard instantiateInitialViewController];
        self.window.rootViewController = controller;
        [self.window addSubview:controller.view];
        [self.window makeKeyAndVisible];
        return YES;
    }

    [self instantiateUserDefinedViewController];
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
    // Possibly check the reset token
    
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


- (void)instantiateUserDefinedViewController
{
    // system settings
    NSNumber *display = [[NSUserDefaults standardUserDefaults] valueForKey:@"disp"];
    
    // select storyboard and initial viewController
    UIStoryboard *storyBoard = nil;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        switch (display.intValue) {
            default:
            case 0: // Table layout
                storyBoard = [UIStoryboard storyboardWithName:@"TableLayoutStoryboard_iPad" bundle:nil];
                break;
            case 1:
                break;
        }
    }else{
        //CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        //if (iOSDeviceScreenSize.height == 480) or if (iOSDeviceScreenSize.height == 568)
        switch (display.intValue) {
            default:
            case 0: // Table layout
                storyBoard = [UIStoryboard storyboardWithName:@"TableLayoutStoryboard_iPhone" bundle:nil];
                break;
            case 1:
                break;
        }
    }

    if (storyBoard==NULL)
    NSLog(@"The controller is null");
    UIViewController * controller = [storyBoard instantiateInitialViewController];

    //!TODO
    _dataManager = [[DataManager alloc] init];

    self.window.rootViewController = controller;
    [self.window addSubview:controller.view];
    [self.window makeKeyAndVisible];
}

@end
