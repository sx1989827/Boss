//
//  PreStartView.m
//  Boss
//
//  Created by 孙昕 on 15/12/6.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "PreStartView.h"

@implementation PreStartView
+(void)show:(void (^)())block
{
    PreStartView *view=[[[self class] alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(20, 50, view.bounds.size.width-40, view.bounds.size.height-100)];
    lb.textAlignment=NSTextAlignmentCenter;
    lb.font=[UIFont fontWithName:@"Chalkduster" size:50];
    lb.textColor=[UIColor colorWithRed:1.000 green:0.732 blue:0.000 alpha:1.000];
    lb.text=@"Three";
    [view addSubview:lb];
    lb.center=view.center;
    [UIView animateWithDuration:1 animations:^{
        lb.alpha=0;
    } completion:^(BOOL finished) {
        lb.text=@"Two";
        lb.alpha=1;
        [UIView animateWithDuration:1 animations:^{
            lb.alpha=0;
        } completion:^(BOOL finished) {
            lb.text=@"One";
            lb.alpha=1;
            [UIView animateWithDuration:1 animations:^{
                lb.alpha=0;
            } completion:^(BOOL finished) {
                lb.text=@"Go";
                lb.alpha=1;
                [UIView animateWithDuration:0.5 delay:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    lb.center=CGPointMake(lb.center.x, -100);
                    view.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0];
                } completion:^(BOOL finished) {
                    if(block)
                    {
                        block();
                    }
                    [lb removeFromSuperview];
                    [view removeFromSuperview];
                }];
            }];
            
        }];
    }];
}

@end









