//
//  AppDelegate.m
//  MySMSBrandName
//
//  Created by Le Van Binh on 6/17/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MyUtil.h"
#import <RestKit/RestKit.h>
#import "RestKitDAO.h"
#import <SlideNavigationController.h>
#import "LeftMenuViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
       
    
    
    
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    SlideNavigationController *_slideNavigationController = [[SlideNavigationController alloc] initWithRootViewController:loginVC];
    LeftMenuViewController *leftMenu = [[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController" bundle:nil];
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    //Slide menu
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateNormal];
    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [SlideNavigationController sharedInstance].leftBarButtonItem = leftBarButtonItem;

    
    self.window.rootViewController = _slideNavigationController;
    
   
    
    //Configure RestKit
    RestKitDAO *objRestKitDAO = [[RestKitDAO alloc] init];
    [objRestKitDAO configureRestKit];
    
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

@end
