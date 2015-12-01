//
//  SliderView.m
//  RunMan-User
//
//  Created by 孙昕 on 15/5/22.
//  Copyright (c) 2015年 孙昕. All rights reserved.
//

#import "SliderView.h"
@interface CustomSlider:UISlider

@end
@implementation CustomSlider
- (CGRect)trackRectForBounds:(CGRect)bounds
{
    bounds.size.height=12;
    return bounds;
}


@end
@interface SliderView()
{
    CustomSlider *sliderView;
    UIButton *btnTag;
}
@end
@implementation SliderView
-(instancetype)initWithFrame:(CGRect)frame Min:(float)min Max:(float)max;
{
    if(self=[super initWithFrame:frame])
    {
        CGRect frameSlider=frame;
        frameSlider.origin.y=40;
        frameSlider.size.height=10;
        frameSlider.origin.x=5;
        frameSlider.size.width=frame.size.width-10;
        sliderView=[[CustomSlider alloc] initWithFrame:frameSlider];
        sliderView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        [sliderView setThumbImage:[UIImage imageNamed:@"slidercenter.png"] forState:UIControlStateNormal];
        [sliderView setThumbImage:[UIImage imageNamed:@"slidercenter.png"] forState:UIControlStateHighlighted];
        [self addSubview:sliderView];
        [sliderView setMinimumValue:min];
        [sliderView setMaximumValue:max];
        [sliderView setValue:min];
        sliderView.continuous=YES;
        btnTag=[UIButton buttonWithType:UIButtonTypeCustom];
        btnTag.frame=CGRectMake(10, -10, 40, 30);
        [btnTag setBackgroundColor:[UIColor clearColor]];
        [btnTag setBackgroundImage:[UIImage imageNamed:@"slidertag.png"] forState:UIControlStateNormal];
        CGRect trackRect = [sliderView trackRectForBounds:sliderView.bounds];
        CGRect thumbRect = [sliderView thumbRectForBounds:sliderView.bounds
                                                 trackRect:trackRect
                                                     value:sliderView.value];
        CGPoint p=CGPointMake(sliderView.frame.origin.x+ thumbRect.origin.x+thumbRect.size.width/2,20);
        btnTag.center=p;
        [btnTag.titleLabel setFont:[UIFont fontWithName:btnTag.titleLabel.font.familyName size:14]];
        [btnTag setTitleEdgeInsets:UIEdgeInsetsMake(-5, 0, 0, 0)];
        [btnTag setTitle:[NSString stringWithFormat:@"%ld",(NSInteger)sliderView.value]  forState:UIControlStateNormal];
        [self addSubview:btnTag];
        [sliderView addTarget:self action:@selector(changed:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void)changed:(UISlider*)slider
{
    [btnTag setTitle:[NSString stringWithFormat:@"%ld",(NSInteger)sliderView.value]  forState:UIControlStateNormal];
    CGRect trackRect = [sliderView trackRectForBounds:sliderView.bounds];
    CGRect thumbRect = [sliderView thumbRectForBounds:sliderView.bounds
                                            trackRect:trackRect
                                                value:sliderView.value];
    CGPoint p=CGPointMake(sliderView.frame.origin.x+ thumbRect.origin.x+thumbRect.size.width/2,20);
    btnTag.center=p;
}


-(NSInteger)value
{
    return sliderView.value;
}

-(void)setValue:(NSInteger)value
{
    [sliderView setValue:value animated:YES];
    [self changed:sliderView];
}
@end








