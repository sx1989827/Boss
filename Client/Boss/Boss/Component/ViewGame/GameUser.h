//
//  GameUser.h
//  SKTest
//
//  Created by 孙昕 on 15/11/30.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "GameDefine.h"
@interface GameUser : NSObject
@property (assign,nonatomic) NSInteger money;
@property (strong,nonatomic) SKSpriteNode *node;
-(void)update;
-(void)remove;
-(void)postPower:(PowerType)power Value:(NSInteger)value;
@end
