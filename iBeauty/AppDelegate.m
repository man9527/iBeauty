//
//  AppDelegate.m
//  iBeauty
//
//  Created by 宏揚 朱 on 12/4/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "SelectedPhotoViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

// - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.supportsShakeToReload = YES;
    navigator.persistenceMode = TTNavigatorPersistenceModeAll;
    
    TTURLMap* map = navigator.URLMap;
    [map from:@"*" toViewController:[TTWebController class]];    
    
    [map from:@"tt://tabBar/(initWithSelectedIndex:)" toSharedViewController:[TabBarController class]];
    [map from:@"tt://firstTab" toSharedViewController:[FirstViewController class]];
    [map from:@"tt://secondTab" toSharedViewController:[SecondViewController class]];
    [map from:@"tt://thirdTab" toSharedViewController:[ThirdViewController class]];
    [map from:@"tt://selectedPhoto/(initWithShareId:)" toSharedViewController:[SelectedPhotoViewController class]];
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    // Override point for customization after application launch.
//    UIViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
//    UIViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
//    UIViewController *viewController3 = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil];
//    
//    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
//    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
//    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
//    
//    self.tabBarController = [[UITabBarController alloc] init];
//    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, navController3, nil];
//    
//    self.window.rootViewController = self.tabBarController;
//    [self.window makeKeyAndVisible];
//
//    // Override point for customization after application launch.
//    UITabBarController* root = (UITabBarController*)self.window.rootViewController;
//    root.selectedIndex = 1;

    //if (![navigator restoreViewControllers]) {
       [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabBar/1"]];
    //[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://selectedPhoto"]];
    //}
    
    // return YES;
}


//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:url.absoluteString]];
//    return YES;
//}

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
