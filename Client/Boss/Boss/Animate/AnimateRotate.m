//
//  AnimateRotate.m
//  Boss
//
//  Created by 孙昕 on 15/12/7.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "AnimateRotate.h"

@implementation AnimateRotate
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC= [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    CGRect frame=[transitionContext finalFrameForViewController:toVC];
    toVC.view.frame=frame;
    toVC.view.transform=CGAffineTransformMakeRotation(-180 *M_PI / 180.0);
    toVC.view.alpha=0;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toVC.view.alpha=1;
        toVC.view.transform=CGAffineTransformMakeRotation(-360 *M_PI / 180.0);
        fromVC.view.alpha=0;
        fromVC.view.transform=CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.view.alpha=1;
        fromVC.view.transform=CGAffineTransformMakeRotation(0 *M_PI / 180.0);
    }];
}

@end
