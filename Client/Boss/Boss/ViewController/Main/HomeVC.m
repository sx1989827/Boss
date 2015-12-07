//
//  HomeVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "HomeVC.h"
#import "Header.h"
@interface HomeVC ()<UINavigationControllerDelegate>

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    self.title=@"首页";
    [self hideBackButton];
    [_tableMain setDelegateAndDataSource:self];
    [_tableMain disablePage];
    [_tableMain registarCell:@"TypeCell" StrItem:@"TypeItem"];
    [_tableMain reloadRequest:[NSString stringWithFormat:@"%@%@",serverUrl,@"/level/type"] Param:@{
                                                @"username":USERNAME,
                                                @"pwd":PWD
                                            }];
}

-(NSArray*)LazyTableViewDidFinishRequest:(LazyTableView *)tableview Request:(NSDictionary *)dic
{
    return dic[@"data"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


@end









