//
//  LevelVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "LevelVC.h"
#import "LevelView.h"
#import "LevelInfoReq.h"
#import "Header.h"
@interface LevelVC ()<LevelViewDelegate>
{
    LevelView *viewLevel;
    NSArray *arrLevel;
    NSInteger indexLevel;
}
@end

@implementation LevelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关卡";
    [LevelInfoReq do:^(id req) {
        LevelInfoReq *obj=req;
        obj.type=_type;
    } Res:^(id res) {
        LevelInfoRes *obj=res;
        if(obj.code==0)
        {
            arrLevel=obj.data.totleLevel;
            indexLevel=[arrLevel indexOfObject:obj.data.level];
            viewLevel=[[LevelView alloc] initWithNodes:[arrLevel subarrayWithRange:NSMakeRange(0, indexLevel+2)] UserIndex:indexLevel MaxCount:arrLevel.count];
            viewLevel.delegateNode=self;
            viewLevel.frame=CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
            viewLevel.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            [self.view addSubview:viewLevel];
            [[UserDefaults sharedInstance] updatePeopleInfo:^(NSDictionary *dic) {
                [[UserDefaults sharedInstance] updatePowerInfo:^(NSDictionary *dic){
                    [self removeHud];
                    self.bHud=NO;
                } Hud:NO];
            } Hud:NO];
        }
        else
        {
            E(obj.msg);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } ShowHud:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)LevelViewClick:(NSInteger)index Text:(NSString *)text
{
    if(index>indexLevel)
    {
        [self pushViewController:@"LevelSetVC" Param:@{
                                           @"type":_type,
                                           @"level":text
                                                       }];
    }
}
@end






