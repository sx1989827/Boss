//
//  MoneyPower.m
//  SKTest
//
//  Created by 孙昕 on 15/12/3.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "MoneyPower.h"
#import "GameDefine.h"
#import "ViewSence.h"
@implementation MoneyPower
-(instancetype)initWithName:(PowerType)name Value:(NSInteger)value
{
    if(self=[super init])
    {
        self.name=name;
        self.value=value;
        userMoney+=value;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self remove];
        });
        [[ViewSence sharedInstance] runAction:[SKAction playSoundFileNamed:@"加工资.wav" waitForCompletion:NO]];
    }
    return self;
}

-(void)remove
{
    [super remove];
}


-(void)hurtEnemy:(GameEnemy*)enemy
{
    
}

@end
