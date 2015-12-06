//
//  GameDefine.h
//  SKTest
//
//  Created by 孙昕 on 15/11/30.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UserFlag (0x1<<0)
#define EnemyFlag (0x1<<1)
#define EnemyPowerFlag (0x1<<2)
#define BarrierPowerFlag (0x1<<3)
#define BulletPowerFlag (0x1<<4)
#define BombPowerFlag (0x1<<5)
#define LaserPowerFlag (0x1<<6)
#define EdgeFlag (0x1<<7)
extern float screenWidthExtra;
extern NSInteger totleTime;
extern NSInteger userMoney;
extern NSInteger totleScore;
extern NSInteger originTime;
typedef NS_ENUM(NSUInteger, PowerType) {
    Time,
    Barrier,
    Bullet,
    Money,
    Bomb,
    Laser
};