//
//  ChooseView.h
//  Boss
//
//  Created by 孙昕 on 15/12/6.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChooseView;
@protocol ChooseViewDelegate<NSObject>
-(void)ChooseIndex:(ChooseView*)view Index:(NSInteger)index Text:(NSString*)text;
@end
@interface ChooseView : UIVisualEffectView
-(void)addItem:(NSArray*)arrText;
-(void)showInView:(UIView*)view;
@property (weak,nonatomic) id<ChooseViewDelegate> delegate;
@end
