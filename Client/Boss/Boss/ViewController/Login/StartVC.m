//
//  StartVC.m
//  Boss
//
//  Created by 孙昕 on 15/12/7.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "StartVC.h"
#import "AppDelegate.h"
#import "Header.h"
@interface StartVC ()

@end

@implementation StartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
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
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showMainTab
{
    Class cls=NSClassFromString(@"MainTabVC");
    UITabBarController *vc=[[cls alloc] init];
    AppDelegate *app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    app.window.rootViewController=vc;
}

-(void)showLoginVC
{
    [self pushViewController:@"LoginVC" Param:nil];
}
@end





