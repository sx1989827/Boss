//
//  EnemyPower.h
//  SKTest
//
//  Created by 孙昕 on 15/12/3.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
@class GameUser;
@interface EnemyPower : NSObject
-(instancetype)initWithValue:(NSInteger)value;
-(void)remove;
-(void)hurtUser:(GameUser*)user;
@property (assign,nonatomic) NSInteger value;
@property (strong,nonatomic) SKSpriteNode *node;
@end
