//
//  LevelGameVC.m
//  Boss
//
//  Created by 孙昕 on 15/12/4.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "LevelGameVC.h"
#import "ViewGame.h"
#import "Header.h"
#import "ChooseView.h"
#import "PreStartView.h"
#import "LevelLeaveReq.h"
#import "IntroView.h"
@interface LevelGameVC ()<ViewGameDelegate,ItemViewDelegate,ChooseViewDelegate>
{
    ViewGame *game;
    LevelStartData *itemData;
    NSMutableArray *arrWrong;
    NSString *ok;
    NSString *createTime;
    NSInteger questionCount;
}
@end

@implementation LevelGameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    srand((unsigned int)time(0));
    createTime=[[NSDate date] stringValue];
    arrWrong=[[NSMutableArray alloc] initWithCapacity:30];
    game=[[ViewGame alloc] initWithPowerCount:_powerCount Money:[[UserDefaults sharedInstance] money:[[UserDefaults sharedInstance] level:_type]] Time:_time Enemy:_dicEnemy LevelName:_level Delegate:self];
    [self.view addSubview:game];
    _viewItem.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self removeHud];
    [PreStartView show:^{
        [game start];
        [self finishQuestion];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [game pause];
            [IntroView showTitle:@[@{
                                       @"title":@"这里是你的工资，工资不能小于等于0",
                                       @"rect":[NSValue valueWithCGRect:CGRectMake(20, 300, 200, 60)],
                                       @"view":game.lbMoney
                                       },@{
                                       @"title":@"这里是你的剩余子弹数，在规定的子弹数内必须将敌人全部消灭",
                                       @"rect":[NSValue valueWithCGRect:CGRectMake(20, 300, 300, 60)],
                                       @"view":game.lbPower
                                       },@{
                                       @"title":@"这里是你的积分，没消灭一个敌人积分会增长，通关时间越少积分越多",
                                       @"rect":[NSValue valueWithCGRect:CGRectMake(20, 300, 300, 60)],
                                       @"view":game.lbScore
                                       },@{
                                       @"title":@"这里是你的剩余时间，必须在指定时间内干掉所有敌人",
                                       @"rect":[NSValue valueWithCGRect:CGRectMake(20, 300, 300, 60)],
                                       @"view":game.lbTime
                                       },@{
                                       @"title":@"这里是选择子弹页，每个不同的子弹用途不一样，每答对一道题目便会发挥子弹的用途，答错你会被扣工资",
                                       @"rect":[NSValue valueWithCGRect:CGRectMake(20, 20, 300, 90)],
                                       @"view":[self.view viewWithTag:1]
                                       }] Block:^{
                                           [game resume];
                                       }];
        });
    }];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)clickQuestion:(NSInteger)index
{
    LevelStartAnswer* answer= itemData.answer[index];
    NSMutableArray *arrOrigin=[[NSMutableArray alloc] initWithArray:answer.wrong];
    ok=answer.ok;
    NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:30];
    [arr addObject:answer.ok];
    for(int i=0;i<3;i++)
    {
        NSInteger index=rand()%arrOrigin.count;
        id value=arrOrigin[index];
        if([value isKindOfClass:[NSNumber class]])
        {
            [arr addObject:[value stringValue]];
        }
        else
        {
            [arr addObject:value];
        }
        [arrOrigin removeObjectAtIndex:index];
    }
    for(int i = 0; i< arr.count; i++)
    {
        int m = (arc4random() % (arr.count - i)) + i;
        [arr exchangeObjectAtIndex:i withObjectAtIndex: m];
    }
    ChooseView *view=[[ChooseView alloc] init];
    view.tag=0;
    view.delegate=self;
    [view addItem:arr];
    [view showInView:_viewScroll];
}

-(void)finishQuestion
{
    NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:30];
    for(LevelStartModel *model in _arrItem)
    {
        if([model.index integerValue]!=model.data.count)
        {
            [arr addObject:model.name];
        }
    }
    if(arr.count==0)
    {
        return;
    }
    ChooseView *view=[[ChooseView alloc] init];
    view.tag=1;
    view.delegate=self;
    [view addItem:arr];
    [view showInView:_viewScroll];
}

-(void)ChooseIndex:(ChooseView *)view Index:(NSInteger)index Text:(NSString *)text
{
    if(view.tag==0)
    {
        UIImageView *view=[[UIImageView alloc] initWithFrame:_viewScroll.bounds];
        view.backgroundColor=[UIColor clearColor];
        view.contentMode=UIViewContentModeCenter;
        [_viewScroll addSubview:view];
        if([text isEqualToString:ok])
        {
            [_viewItem setOK:YES Text:text];
            questionCount--;
            if(questionCount==0)
            {
                [game postPower:itemData.power Value:[[UserDefaults sharedInstance] powerName:itemData.power]];
            }
            view.image=[UIImage imageNamed:@"ok"];
        }
        else
        {
            [_viewItem setOK:NO Text:text];
            [arrWrong addObject:itemData._id];
            [game hurtUser:[[UserDefaults sharedInstance] powerName:itemData.power]/2];
            view.image=[UIImage imageNamed:@"wrong"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view removeFromSuperview];
        });
    }
    else if(view.tag==1)
    {
        NSString *content=[self getItem:text];
        [_viewItem addItem:content Flag:@"(?)"];
    }
}

-(NSString*)getItem:(NSString*)name
{
    for(LevelStartModel *model in _arrItem)
    {
        if([model.name isEqualToString:name])
        {
            LevelStartData *data=model.data[[model.index integerValue]];
            model.index=@([model.index integerValue]+1);
            itemData=data;
            questionCount=data.answer.count;
            return data.content;
        }
    }
    return nil;
}

-(void)over:(BOOL)bWin UseTime:(NSInteger)useTime Score:(NSInteger)score
{
    NSString *str=[NSString stringWithFormat:@"耗时:%ld秒 获取积分:%ld",useTime,score];
    NSString *title;
    if(_bChallenge)
    {
        if(bWin)
        {
            title=@"挑战成功";
        }
        else
        {
            title=@"挑战失败";
        }
    }
    else
    {
        if(bWin)
        {
            title=@"蹂躏成功";
        }
        else
        {
            title=@"蹂躏失败";
        }
    }
    [TipView showWithTitle:title Tip:[NSString stringWithFormat:@"%@ %@",bWin?@"你太棒啦！":@"你一辈子都是个屌丝！",str] Block:^{
        [LevelLeaveReq do:^(id req) {
            LevelLeaveReq *obj=req;
            obj.type=_type;
            obj.level=_level;
            obj.success=bWin?1:0;
            obj.createtime=createTime;
            obj.usetime=[NSString stringWithFormat:@"%ld",useTime];
            obj.percent=(_powerCount-arrWrong.count)*1.0/_powerCount;
            obj.score=score;
            obj.item=[arrWrong componentsJoinedByString:@","];
            obj.challenge=_bChallenge;
        } Res:^(id res) {
            LevelLeaveRes *obj=res;
            if(obj.code==0)
            {
                [[UserDefaults sharedInstance] updateScore:obj.data.score];
                [[UserDefaults sharedInstance] updateLevel:_type Level:obj.data.level];
                if(bWin && _bChallenge)
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:msgUpdateLevel object:nil userInfo:@{@"level":obj.data.level}];
                    });
                }  
            }
            else
            {
                E(obj.msg);
            }
            for(UIViewController *vc in self.navigationController.viewControllers)
            {
                if([vc isKindOfClass:NSClassFromString(@"LevelVC")])
                {
                    self.navigationController.navigationBarHidden=NO;
                    [self.navigationController popToViewController:vc animated:YES];
                    break;
                }
            }
        } ShowHud:YES];
    }];
}
@end













