//
//  TimePower.m
//  SKTest
//
//  Created by 孙昕 on 15/12/1.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "TimePower.h"
#import "GameDefine.h"
@interface TimePower()
@end
@implementation TimePower
-(instancetype)initWithName:(PowerType)name Value:(NSInteger)value
{
    if(self=[super init])
    {
        self.name=name;
        self.value=value;
        totleTime+=value;
        originTime+=value;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self remove];
        });
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





