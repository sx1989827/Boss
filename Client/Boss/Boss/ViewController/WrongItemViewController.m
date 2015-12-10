//
//  WrongItemViewController.m
//  Boss
//
//  Created by libruce on 15/12/10.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "WrongItemViewController.h"
#import "Util.h"
#import "Header.h"
@interface WrongItemViewController ()<LazyTableViewDelegate>

@end

@implementation WrongItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud = NO;
    NSLog(@"item===%@",self.item);
    self.title = @"错题";
    NSString *str ;
    for (int i=0; i<self.item.count; i++) {
        NSString *string = self.item[i];
        if (i==0) {
            str = string;
        }else
        {
            str = [NSString stringWithFormat:@",%@",string];
        }
    }
    [_mainTableView  setDelegateAndDataSource:self];
    [_mainTableView registarCell:@"WrongItemCell" StrItem:@"WrongItem"];
    [_mainTableView reloadRequest:[NSString stringWithFormat:@"%@/item",serverUrl] Param:@{@"username":USERNAME,
                                                                                           @"pwd":PWD,
                                                                                           @"id":str}];
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
