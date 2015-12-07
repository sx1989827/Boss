//
//  ViewTest.h
//  SKTest
//
//  Created by 孙昕 on 15/11/28.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ViewGameProtovol.h"
@interface ViewGame : SKView
-(instancetype)initWithPowerCount:(NSInteger)count Money:(NSInteger)money Time:(NSInteger)usetime Enemy:(NSDictionary*)enemy LevelName:(NSString*)levelName Delegate:(id<ViewGameDelegate>)delegate;
@property (strong, nonatomic) IBOutlet UILabel *lbMoney;
@property (strong, nonatomic) IBOutlet UILabel *lbScore;
@property (strong, nonatomic) IBOutlet UILabel *lbTime;
@property (strong, nonatomic) IBOutlet UILabel *lbPower;

-(void)start;
-(void)stop;
-(void)postPower:(NSString*)power Value:(NSInteger)value;
-(void)hurtUser:(NSInteger)value;
@end
