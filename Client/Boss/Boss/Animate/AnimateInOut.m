//
//  AnimateInOut.m
//  Boss
//
//  Created by 孙昕 on 15/12/7.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "AnimateInOut.h"

@implementation AnimateInOut
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC= [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    CGRect frame=[transitionContext finalFrameForViewController:toVC];
    toVC.view.frame=frame;
    toVC.view.alpha=0;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toVC.view.alpha=1;
        fromVC.view.alpha=0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.view.alpha=1;
    }];
}

@end
