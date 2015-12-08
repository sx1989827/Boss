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
#import "AnimateRotate.h"
@interface LevelVC ()<LevelViewDelegate,UINavigationControllerDelegate>
{
    LevelView *viewLevel;
    NSArray *arrLevel;
    NSInteger indexLevel;
    AnimateRotate *ani;
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
            [[UserDefaults sharedInstance] updateScore:obj.data.score];
            arrLevel=obj.data.totleLevel;
            indexLevel=[arrLevel indexOfObject:obj.data.level];
            [[UserDefaults sharedInstance] updateLevel:_type Level:obj.data.level];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLevel:) name:msgUpdateLevel object:nil];
    ani=[[AnimateRotate alloc] init];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        self.navigationController.delegate=self;
        [self pushViewController:@"LevelSetVC" Param:@{
                                           @"type":_type,
                                           @"level":text
                                                       }];
    }
}

-(void)updateLevel:(NSNotification*)nofi
{
    indexLevel++;
    if(indexLevel>=arrLevel.count)
    {
        return;
    }
    [viewLevel updateUser:arrLevel[indexLevel+1]];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if(operation==UINavigationControllerOperationPush)
    {
        if(fromVC==self)
        {
            return ani;
        }
    }
    return nil;
}
@end






