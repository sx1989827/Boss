//
//  percentView.h
//  Boss
//
//  Created by libruce on 15/12/8.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PercentView : UIView
@property(nonatomic)CGFloat    percent;
@property(nonatomic)CGFloat    startAngle;
@property(nonatomic)CGFloat    endInnerAngle;
@property(nonatomic,strong)UIColor    *fillColor;
@property(nonatomic,strong)UIColor    *unfillColor;
@property(nonatomic,strong)UILabel    *percentLabel;
@property(nonatomic)CGFloat    lineWith;
-(instancetype)initWIthPercent:(NSNumber*)percent showInView:(UIView*)shouInView;
@end
