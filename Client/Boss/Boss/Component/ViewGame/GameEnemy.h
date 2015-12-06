//
//  GameEnemy.h
//  SKTest
//
//  Created by 孙昕 on 15/11/30.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
@class GameUser;
@interface GameEnemy : NSObject
@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) NSInteger money;
@property (assign,nonatomic) float speed;
@property (strong,nonatomic) SKSpriteNode *node;
@property (assign,nonatomic) BOOL bBoss;
-(instancetype)initWithName:(NSString*)name Money:(NSInteger)money Speed:(float)speed;
-(void)update;
-(void)remove;
-(void)hurtUser:(GameUser*)user;
-(void)pause;
-(void)resume;
@end
