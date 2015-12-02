//
//  AppDelegate.m
//  Boss
//
//  Created by 孙昕 on 15/11/20.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor=[UIColor whiteColor];
    [self initApp];
    if([[UserDefaults sharedInstance] isAvailable])
    {
        [[UserDefaults sharedInstance] update:nil Pwd:nil SucBlock:^(UserInfoModel *model) {
            [self showMainTab];
        } FailBlock:^(NSString *msg) {
            NSLog(@"%@",msg);
            [self showLoginVC];
        }  Hud:NO];
    }
    else
    {
        [self showLoginVC];
    }
    return YES;

}

-(void)initApp
{
    [[UINavigationBar appearance] setBarTintColor:COL(34, 51, 61, 1)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)showMainTab
{
    Class cls=NSClassFromString(@"MainTabVC");
    UITabBarController *vc=[[cls alloc] init];
    _window.rootViewController=vc;
    [self.window makeKeyAndVisible];
}

-(void)showLoginVC
{
    Class cls=NSClassFromString(@"LoginVC");
    UIViewController *vc=[[cls alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:vc];
    _window.rootViewController=nav;
    [self.window makeKeyAndVisible];
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
