//
//  MainTabVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "MainTabVC.h"
#import "HomeVC.h"
#import "RankVC.h"
#import "MemberVC.h"
@interface MainTabVC ()

@end

@implementation MainTabVC
-(instancetype)init
{
    if(self=[super init])
    {
        HomeVC *vc1=[[HomeVC alloc] init];
        vc1.tabBarItem.title=@"首页";
        vc1.tabBarItem.image=[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc1.tabBarItem.selectedImage=[[UIImage imageNamed:@"homesel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        RankVC *vc2=[[RankVC alloc] init];
        vc2.tabBarItem.title=@"排行";
        vc2.tabBarItem.image=[[UIImage imageNamed:@"rank"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc2.tabBarItem.selectedImage=[[UIImage imageNamed:@"ranksel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        MemberVC *vc3=[[MemberVC alloc] init];
        vc3.tabBarItem.title=@"我的";
        vc3.tabBarItem.image=[[UIImage imageNamed:@"member"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc3.tabBarItem.selectedImage=[[UIImage imageNamed:@"membersel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:vc1];
        UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:vc2];
        UINavigationController *nav3=[[UINavigationController alloc] initWithRootViewController:vc3];
        self.viewControllers=@[nav1,nav2,nav3];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
