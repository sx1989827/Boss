//
//  MyPower.m
//  SKTest
//
//  Created by 孙昕 on 15/12/1.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "MyPower.h"
#import "ViewSence.h"
@implementation MyPower

-(void)remove
{
    [self.node removeAllActions];
	NSMutableArray *arr=[[ViewSence sharedInstance] valueForKey:@"arrPower"];
    [arr removeObject:self];
}

-(void)hurtEnemy:(GameEnemy*)enemy
{
	
}

+(instancetype)create:(PowerType)type Value:(NSInteger)value
{
    MyPower* obj=nil;
    Class cls;
    switch (type)
    {
        case Time:
        {
            cls=NSClassFromString(@"TimePower");
            break;
        }
        case Barrier:
        {
            cls=NSClassFromString(@"BarrierPower");
            break;
        }
        case Bullet:
        {
            cls=NSClassFromString(@"BulletPower");
            break;
        }
        case Money:
        {
            cls=NSClassFromString(@"MoneyPower");
            break;
        }
        case Bomb:
        {
            cls=NSClassFromString(@"BombPower");
            break;
        }
        case Laser:
        {
            cls=NSClassFromString(@"LaserPower");
            break;
        }
        default:
            break;
    }
    NSMutableArray *arr=[[ViewSence sharedInstance] valueForKey:@"arrPower"];
    obj=[[cls alloc] initWithName:type Value:value];
    [arr addObject:obj];
    return obj;
}

-(void)effect:(GameEnemy *)enemy Offset:(NSInteger)offset
{
	
}
@end








