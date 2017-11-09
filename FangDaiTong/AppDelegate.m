//
//  AppDelegate.m
//  FangDaiTong
//
//  Created by yhj on 2017/9/27.
//  Copyright © 2017年 yhj. All rights reserved.
//

#import "AppDelegate.h"
#import "YHTabBarViewController.h"
#import "YHNavigationViewController.h"
#import "LoginViewController.h"
#import "IndexViewController.h"

@interface AppDelegate ()
@property(nonatomic, strong)YHTabBarViewController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 3.显示Windows
    //ZMUser *user = [ZMUser accountFromSandbox];
   [self setupMainTabController];
   // LoginViewController *logVc = [[LoginViewController alloc ] init];
    //self.window.rootViewController = logVc;
   // YHNavigationViewController *navVc = [[YHNavigationViewController alloc]initWithRootViewController:logVc];
   
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupMainTabController
{
    YHTabBarViewController *tabBarController = [[YHTabBarViewController alloc] init];
    self.tabBarController = tabBarController;
    self.window.rootViewController = tabBarController;
  
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


@end
