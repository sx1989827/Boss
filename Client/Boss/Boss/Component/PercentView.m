//
//  percentView.m
//  Boss
//
//  Created by libruce on 15/12/8.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "percentView.h"
@interface PercentView ()
{
    CGFloat radius;
}
@property(nonatomic) CGPoint CGPoinCerter;
@property(nonatomic) CGFloat endAngle;
@property(nonatomic) BOOL clockwise;

@end
@implementation PercentView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        self.fillColor = [UIColor redColor];
        self.unfillColor = [UIColor yellowColor];
        self.startAngle = 180.0;
        self.endInnerAngle =360.0;
        self.lineWith =5.0;
        self.percentLabel.text =@"正确率";
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
