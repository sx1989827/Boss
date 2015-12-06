//
//  MyPower.h
//  SKTest
//
//  Created by 孙昕 on 15/12/1.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "GameDefine.h"
@class  GameEnemy;
@interface MyPower : NSObject
@property (assign,nonatomic) PowerType name;
@property (assign,nonatomic) NSInteger value;
@property (strong,nonatomic) SKSpriteNode *node;
@property (assign,nonatomic) CGRect contactRect;
-(void)remove;
-(void)hurtEnemy:(GameEnemy*)enemy;
-(void)effect:(GameEnemy*)enemy Offset:(NSInteger)offset;
+(instancetype)create:(PowerType)type Value:(NSInteger)value;
@end
@interface MyPower (init)
-(instancetype)initWithName:(PowerType)name Value:(NSInteger)value;
@end
