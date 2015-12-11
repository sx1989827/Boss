//
//  RecodeHistoryViewController.m
//  Boss
//
//  Created by libruce on 15/12/7.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "RecodeHistoryViewController.h"
#import "HistoryCell.h"
#import "Util.h"
#import "Header.h"
#import "TypeView.h"
#import "TypeReq.h"
#import "SGSheetMenu.h"
@interface RecodeHistoryViewController ()<LazyTableViewDelegate>
{
    
    TypeView *_typeView;
    NSInteger _selected;
}
@end

@implementation RecodeHistoryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud =NO;
    _typeView = [[[NSBundle mainBundle] loadNibNamed:@"TypeView" owner:nil options:nil] lastObject];
    [_typeView.typeSelectButton addTarget:self action:@selector(typeSelected:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _typeView;
    [_mainTableView setDelegateAndDataSource:self];
    [_mainTableView registarCell:@"HistoryCell" StrItem:@"HistoryItem"];
    [_mainTableView setPageParam:@"page" Page:0];
    [_mainTableView reloadRequest:[NSString stringWithFormat:@"%@/user/history",serverUrl] Param:@{@"username":USERNAME,@"pwd":PWD,@"type":_type}];
}
-(NSArray*)LazyTableViewDidFinishRequest:(LazyTableView *)tableview Request:(NSDictionary *)dic
{
    return dic[@"data"];
}
-(void)typeSelected:(UIButton*)sender
{
             NSMutableArray *typeArray =[[NSMutableArray alloc]initWithCapacity:0];
            [TypeReq do:^(id req) {
                TypeReq*obj =req;
                obj.username =USERNAME;
                obj.pwd =PWD;
            } Res:^(id res) {
                TypeRes *obj =res;
                NSArray *typeModelArray = obj.data;
                [typeModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    TypeModel*model =obj;
                    [typeArray addObject:model.name];
                }];
                [SGActionView showSheetWithTitle:@"选择类型" itemTitles:(NSArray*)typeArray selectedIndex:_selected selectedHandle:^(NSInteger index) {
                    _selected =index;
                    [_typeView.typeSelectButton setTitle:[NSString stringWithFormat:@"%@",typeArray[index]] forState:UIControlStateNormal];
                    _type =typeArray[index];
                    [_mainTableView reload];
                }];
            } ShowHud:YES];
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
