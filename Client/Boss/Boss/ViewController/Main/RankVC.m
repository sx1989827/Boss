//
//  RankVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "RankVC.h"
#import "Header.h"
@interface RankVC ()

@end

@implementation RankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    self.title=@"排行";
    [self hideBackButton];
    [_tableMain setDelegateAndDataSource:self];
    [_tableMain setPageParam:@"page" Page:0];
    [_tableMain registarCell:@"RankCell" StrItem:@"RankItem"];
    [_tableMain reloadRequest:[NSString stringWithFormat:@"%@%@",serverUrl,@"/rank/top"] Param:@{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
