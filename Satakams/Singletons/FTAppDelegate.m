//
//  FTAppDelegate.m
//  Satakams
//
//  Created by Chandu on 10/3/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import "FTAppDelegate.h"
#import "PKRevealController.h"
#import "FTPoemsViewController.h"
#import "FTMenuViewController.h"
#import "FTPoemsCollectionViewController.h"

@implementation FTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Create your controllers.
    FTMenuViewController *menuViewController = [[FTMenuViewController alloc] init];
    FTPoemsCollectionViewController *poemsCollectionViewController = [[FTPoemsCollectionViewController alloc] init];
    menuViewController.menuSelectionDelegate = poemsCollectionViewController;
    UINavigationController *leftNavController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    // TODO: Remove FTPoemsViewController once we are sure off of using collectionViewController.
    //    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:[[FTPoemsViewController alloc] init]];
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:poemsCollectionViewController];
    self.revealController = [PKRevealController revealControllerWithFrontViewController:frontViewController leftViewController:leftNavController options:nil];
    self.window.rootViewController = self.revealController;
    [self.window makeKeyAndVisible];
    
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

@end
