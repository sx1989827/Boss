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
@property(nonatomic,strong)CAShapeLayer   *bgLayer;
@end
@implementation PercentView
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self bgLayer];
        [self shapeLayer];
    }
    
    return self;
}

-(CAShapeLayer*)bgLayer{
    if (!_bgLayer) {
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.lineWidth =5.0;
        _bgLayer.strokeStart =0.0;
        _bgLayer.strokeEnd =1.0;
        _bgLayer.strokeColor = [UIColor grayColor].CGColor;
        _bgLayer.fillColor = [UIColor clearColor].CGColor;
        _bgLayer.path = [self bezierPath].CGPath;
        [self.layer addSublayer:_bgLayer];
    }
       return _bgLayer;
}
-(CAShapeLayer*)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.lineWidth = 5.0;
        _shapeLayer.strokeStart = 0.0;
        _shapeLayer.strokeEnd =1;
        _shapeLayer.speed =1.0;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineJoin = kCALineJoinBevel;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.path = [self bezierPath].CGPath;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}
-(UILabel*)percenLabel{
    
    if (!_percenLabel) {
        _percenLabel =[[ UILabel alloc] init];
        CGRect rect = self.bounds;
        CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
        _percenLabel.frame = CGRectMake(0,0, 45, 20);
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

-(void)setPercent:(CGFloat)percent
{
    _percent=percent;
    NSString *percentString = [NSString stringWithFormat:@"%ld",(NSInteger)(percent*100)];
    NSString * string = [percentString stringByAppendingString:@"%"];
    self.percenLabel.text =string;
    _shapeLayer.strokeEnd =_percent;
}

@end
