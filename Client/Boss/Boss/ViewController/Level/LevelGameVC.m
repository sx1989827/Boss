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
@interface LevelGameVC ()<ViewGameDelegate,ItemViewDelegate,ChooseViewDelegate>
{
    ViewGame *game;
    LevelStartData *itemData;
    NSMutableArray *arrWrong;
    NSString *ok;
}
@end

@implementation LevelGameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    srand((unsigned int)time(0));
    arrWrong=[[NSMutableArray alloc] initWithCapacity:30];
    game=[[ViewGame alloc] initWithPowerCount:_powerCount Money:[[UserDefaults sharedInstance] money:[[UserDefaults sharedInstance] level:_type]] Score:[UserDefaults sharedInstance].resModel.data.score Time:_time Enemy:_dicEnemy LevelName:_level Delegate:self];
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
        if([text isEqualToString:ok])
        {
            [_viewItem setOK:YES Text:text];
            [game postPower:itemData.power Value:[[UserDefaults sharedInstance] powerName:itemData.power]];
        }
        else
        {
            [_viewItem setOK:NO Text:text];
            [game hurtUser:[[UserDefaults sharedInstance] powerName:itemData.power]/2];
        }
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
            return data.content;
        }
    }
    return nil;
}
@end













