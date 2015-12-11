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

@property(nonatomic,strong)CAShapeLayer   *shapeLayer;
@property(nonatomic,strong)UILabel  *percenLabel;
@end
@implementation PercentView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
       
       
    }
    
    return self;
}
-(void)drawRect:(CGRect)rect{
    
    CAShapeLayer* bgLayer = [CAShapeLayer layer];
    bgLayer.lineWidth =5.0;
    bgLayer.strokeStart =0.0;
    bgLayer.strokeEnd =1.0;
    bgLayer.strokeColor = [UIColor grayColor].CGColor;
    bgLayer.fillColor = [UIColor clearColor].CGColor;
    bgLayer.path = [self bezierPath].CGPath;
    [self.layer addSublayer:bgLayer];
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.lineWidth = 5.0;
    _shapeLayer.strokeStart = 0.0;
    _shapeLayer.strokeEnd =self.percent;
    _shapeLayer.speed =1.0;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineJoin = kCALineJoinBevel;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.path = [self bezierPath].CGPath;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:_shapeLayer];
    NSString *percentString = [NSString stringWithFormat:@"%ld",(NSInteger)(self.percent*100)];
    NSString * string = [percentString stringByAppendingString:@"%"];
    self.percenLabel.text =string;
    
}
-(UILabel*)percenLabel{
    
    if (!_percenLabel) {
        _percenLabel =[[ UILabel alloc] init];
        CGRect rect = self.bounds;
        CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
        _percenLabel.frame = CGRectMake(0,0, 40, 20);
        _percenLabel.center = center;
        _percenLabel.textAlignment = NSTextAlignmentCenter;
        _percenLabel.font  =[UIFont systemFontOfSize:13];
        _percenLabel.textColor = [UIColor redColor];
        [self addSubview:_percenLabel];
    }
    return _percenLabel;
    
}
-(UIBezierPath*)bezierPath
{
    CGRect rect = self.bounds;
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:rect.size.width/2 startAngle:-1.5*M_PI endAngle:0.5*M_PI clockwise:YES];
    return  path;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
