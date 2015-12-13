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
#import "DeleteHistoryReq.h"
@interface RecodeHistoryViewController ()<LazyTableViewDelegate>
{
    
    TypeView *_typeView;
    NSInteger _selected;
    NSMutableArray *typeArray;
}
@end

@implementation RecodeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _typeView = [[[NSBundle mainBundle] loadNibNamed:@"TypeView" owner:nil options:nil] lastObject];
    UIButton*deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(0, 0, 40, 25);
    [deleteButton addTarget:self action:@selector(delegateHistory) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitle:@"清空" forState:UIControlStateNormal];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:deleteButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [_typeView.typeSelectButton addTarget:self action:@selector(typeSelected:) forControlEvents:UIControlEventTouchUpInside];
     [self loadRequest];
   
   
    
}
-(NSArray*)LazyTableViewDidFinishRequest:(LazyTableView *)tableview Request:(NSDictionary *)dic
{
    return dic[@"data"];
}
-(void)loadRequest
{
    typeArray =[[NSMutableArray alloc]initWithCapacity:0];
    [TypeReq do:^(id req) {
    } Res:^(id res) {
        [self removeHud];
        TypeRes *obj =res;
        NSArray *typeModelArray = obj.data;
        [typeModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TypeModel*model =obj;
            [typeArray addObject:model.name];
        }];
        _type = typeArray[0];
        [_typeView.typeSelectButton setTitle:_type forState:UIControlStateNormal];
        self.navigationItem.titleView = _typeView;
        [_mainTableView setDelegateAndDataSource:self];
        [_mainTableView registarCell:@"HistoryCell" StrItem:@"HistoryItem"];
        [_mainTableView setPageParam:@"page" Page:0];
        [_mainTableView reloadRequest:[NSString stringWithFormat:@"%@/user/history",serverUrl] Param:@{@"username":USERNAME,@"pwd":PWD,@"type":_type}];
    } ShowHud:NO];
}
-(void)delegateHistory
{
    [DeleteHistoryReq do:^(id req) {
        DeleteHistoryReq*obj =req;
        obj.type = _typeView.typeSelectButton.titleLabel.text;
    } Res:^(id res) {
        DeleteHistoryRes*obj =res;
        if(obj.code==0)
        {
            S(obj.msg);
           
            [_mainTableView reload];
        }
        else
        {
            E(obj.msg);
        }
    } ShowHud:NO];
}
-(void)typeSelected:(UIButton*)sender
{
                [SGActionView showSheetWithTitle:@"选择类型" itemTitles:(NSArray*)typeArray selectedIndex:_selected selectedHandle:^(NSInteger index) {
                    _selected =index;
                    [_typeView.typeSelectButton setTitle:[NSString stringWithFormat:@"%@",typeArray[index]] forState:UIControlStateNormal];
                    _type =typeArray[index];
                    [_mainTableView getParam][@"type"]=_type;
                    [_mainTableView reload];
                }];
           
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
