//
//  BaseViewController.h
//  RunMan-User
//
//  Created by 孙昕 on 15/5/19.
//  Copyright (c) 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(void)onBack;
-(void)hideBackButton;
-(void)removeHud;
@property (assign,readonly,nonatomic) BOOL bFirstAppear;
@property (assign,nonatomic) BOOL bHud;
@property (assign,nonatomic) BOOL bAutoHiddenBar;
@property (strong,nonatomic) UIScrollView* viewScrollAutoHidden;
@end
