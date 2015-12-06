//
//  LevelSetVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "LevelSetVC.h"
#import "Header.h"
#import "LevelEnterReq.h"
#import "EnemyItem.h"
#import "ChooseItemCountView.h"
#import "LevelStartReq.h"
@interface LevelSetVC ()<ChooseItemCountDelegate>
{
    NSMutableArray *arrChooseView;
    NSInteger step;
    NSInteger time;
    NSArray<LevelEnterEnemy*> *arrEnemy;
}
@end

@implementation LevelSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    arrChooseView=[[NSMutableArray alloc] initWithCapacity:30];
    self.title=@"关卡信息";
    [LevelEnterReq do:^(id req) {
        LevelEnterReq *obj=req;
        obj.type=_type;
        obj.level=_level;
    } Res:^(id res) {
        LevelEnterRes *obj=res;
        if(obj.code==0)
        {
            arrEnemy=obj.data.enemy;
            [self handleData:obj.data];
            [self removeHud];
            self.bHud=NO;
        }
        else
        {
            E(obj.msg);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } ShowHud:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleData:(LevelEnterModel*)data
{
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"你要挑战的等级:%@",_level ]];
    [str setAttributes:@{
                         NSForegroundColorAttributeName:[UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000],
                         NSFontAttributeName:[UIFont systemFontOfSize:20]
                         }range:NSMakeRange(8, str.length-8)];
    _lbTitle.attributedText=str;
    [_tableMain setDelegateAndDataSource:self];
    [_tableMain registarCell:@"EnemyCell" StrItem:@"EnemyItem"];
    LazyTableBaseSection *sec=[[LazyTableBaseSection alloc] init];
    sec.titleHeader=@"他的手下";
    sec.headerHeight=30;
    for(LevelEnterEnemy *enemy in data.enemy)
    {
        PeopleInfoModel *model=[[UserDefaults sharedInstance] peopleName:enemy.name];
        EnemyItem *item=[[EnemyItem alloc] init];
        item.name=model.name;
        item.count=enemy.count;
        item.des=model.des;
        [sec addRow:item];
    }
    [_tableMain addSection:sec];
    [_tableMain reloadStatic];
    _conTableHeight.constant=_tableMain.contentSize.height;
    [self.view layoutIfNeeded];
    NSInteger min= data.time/60;
    NSInteger second=data.time%60;
    step=data.step;
    time=data.time;
    _lbDes.text=[NSString stringWithFormat:@"本关有%ld步,你须在%ld分%ld秒内完成!",data.step,min,second];
    _lbDes.layer.masksToBounds=YES;
    _lbDes.layer.cornerRadius=10;
    NSInteger width=[UIScreen mainScreen].bounds.size.width/3;
    NSInteger x=0,y=0;
    NSArray *arrKey=[UserDefaults sharedInstance].dicPower.allKeys;
    for(int i=0;i< arrKey.count;i++)
    {
        NSString *key=arrKey[i];
        ChooseItemCountView *view=[[[NSBundle mainBundle] loadNibNamed:@"ChooseItemCountView" owner:nil options:nil] lastObject];
        view.delegate=self;
        [arrChooseView addObject:view];
        view.translatesAutoresizingMaskIntoConstraints=YES;
        view.frame=CGRectMake(x, y, width, width);
        view.lbTitle.text=key;
        view.lbCount.text=@"0";
        x+=width;
        if(i!=0 && (i+1)%3==0)
        {
            x=0;
            y+=width;
        }
        [_viewItem addSubview:view];
    }
    _conViewHeight.constant=y;
    [self.view layoutIfNeeded];
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(width, 0, 1, y)];
    lb.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [_viewItem addSubview:lb];
    lb=[[UILabel alloc] initWithFrame:CGRectMake(width*2, 0, 1, y)];
    lb.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [_viewItem addSubview:lb];
    NSInteger count=(arrKey.count-1)/3;
    for(int i=0;i<count;i++)
    {
        lb=[[UILabel alloc] initWithFrame:CGRectMake(0, width*(i+1),[UIScreen mainScreen].bounds.size.width , 1)];
        lb.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_viewItem addSubview:lb];
    }
    for(ChooseItemCountView *view in arrChooseView)
    {
        view.lbCount.text=@"5";
    }
}

-(BOOL)ChooseItemCountAdd
{
    NSInteger count=0;
    for(ChooseItemCountView *view in arrChooseView)
    {
        count+=[view.lbCount.text integerValue];
    }
    if(count<step)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (IBAction)onSubmit:(id)sender
{
    NSInteger count=0;
    NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:30];
    for(ChooseItemCountView *view in arrChooseView)
    {
        count+=[view.lbCount.text integerValue];
        [arr addObject:@{
                        @"name":view.lbTitle.text,
                        @"count":@([view.lbCount.text integerValue])
                         }];
    }
    if(count!=step)
    {
        E(@"请正确分配步数");
        return;
    }
    [TipView showWithTitle:@"确认开始！" Tip:@"是否确认开始，即将开始初始化" YesBlock:^{
        [LevelStartReq do:^(id req) {
            LevelStartReq *obj=req;
            obj.type=_type;
            obj.level=_level;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:nil];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                         encoding:NSUTF8StringEncoding];
            obj.power=jsonString;
        } Res:^(id res) {
            LevelStartRes *obj=res;
            if(obj.code==0)
            {
                NSInteger count=0;
                for(LevelStartModel *model in obj.data)
                {
                    model.index=@0;
                    count+=model.data.count;
                }
                NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:30];
                [dic setObject: @{
                                 @"money":@([[UserDefaults sharedInstance] peopleName:_level].money),
                                 @"count":@(1),
                                 @"speed":@([[UserDefaults sharedInstance] peopleName:_level].speed)
                                 }forKey:_level];
                for(LevelEnterEnemy* enemy in arrEnemy)
                {
                    [dic setObject:@{
                                  @"money":@([[UserDefaults sharedInstance] peopleName:enemy.name].money),
                                  @"count":@(enemy.count),
                                  @"speed":@([[UserDefaults sharedInstance] peopleName:enemy.name].speed)
                                     }forKey:enemy.name];
                }
                [self pushViewController:@"LevelGameVC" Param:@{
                                                                @"type":_type,
                                                                @"level":_level,
                                                                @"dicEnemy":dic,
                                                                @"powerCount":@(count),
                                                                @"time":@(time),
                                                                @"arrItem":obj.data
                                                                }];
            }
            else
            {
                E(obj.msg);
            }
        } ShowHud:YES];
    } NoBlock:nil];
}
@end








