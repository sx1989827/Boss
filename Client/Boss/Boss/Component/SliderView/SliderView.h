//
//  SliderView.h
//  RunMan-User
//
//  Created by 孙昕 on 15/5/22.
//  Copyright (c) 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderView : UIView
-(instancetype)initWithFrame:(CGRect)frame Min:(float)min Max:(float)max;
@property (assign,nonatomic) NSInteger value;
@end
