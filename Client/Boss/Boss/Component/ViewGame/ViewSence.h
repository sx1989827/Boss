//
//  ViewSence.h
//  SKTest
//
//  Created by 孙昕 on 15/11/28.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "ViewGameProtovol.h"
@interface ViewSence : SKScene
-(instancetype)initWithSize:(CGSize)size PowerCount:(NSInteger)powercount Money:(NSInteger)money Score:(NSInteger)score Time:(NSInteger)time Enemy:(NSDictionary*)enemy LevelName:(NSString*)levelName Delegate:(id<ViewGameDelegate>)delegate ViewGameDeleagte:(id)object;
+(instancetype)sharedInstance;
-(void)start;
-(void)stop;
-(void)postPower:(NSString*)power Value:(NSInteger)value;
-(void)addScore:(NSInteger)score;
-(void)hurtUser:(NSInteger)value;
@end
