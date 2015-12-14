//
//  ChooseView.m
//  Boss
//
//  Created by 孙昕 on 15/12/6.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ChooseView.h"
#import "Header.h"
@interface ChooseView()
{
    NSArray *arr;
}
@end
@implementation ChooseView

-(void)addItem:(NSArray*)arrText
{
    arr=arrText;
}

-(void)showInView:(UIView*)view
{
    self.frame=view.bounds;
    self.translatesAutoresizingMaskIntoConstraints=YES;
    [view addSubview:self];
    NSInteger gap=(self.bounds.size.height-50*((arr.count-1)/2+1))/((arr.count-1)/2+2);
    NSInteger top=gap;
    float interal=0.2;
    for(int i=0;i<arr.count;i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag=i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame=CGRectMake(self.bounds.size.width, top, (self.bounds.size.width-80)/2, 50) ;
        //btn.titleLabel.font=[UIFont systemFontOfSize:20];
        btn.titleLabel.numberOfLines=0;
//        btn.titleLabel.adjustsFontSizeToFitWidth=YES;
//        btn.titleLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        CGFloat fontSize = [btn.titleLabel.text fontSizeWithFont:[UIFont boldSystemFontOfSize:20] constrainedToSize:CGSizeMake((self.bounds.size.width-80)/2-5, 45)];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        btn.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
        [btn setBackgroundColor:[UIColor colorWithRed:0.204 green:0.678 blue:0.988 alpha:1.000]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=5;
        if((i+1)%2==0)
        {
            top+=50+gap;
        }
        [self.contentView addSubview:btn];
        [UIView animateWithDuration:0.2 delay:interal options:UIViewAnimationOptionCurveEaseOut animations:^{
            btn.frame=CGRectMake((self.bounds.size.width/2-btn.bounds.size.width)/2+(btn.tag%2==0?0:self.bounds.size.width/2), btn.frame.origin.y, btn.bounds.size.width, btn.bounds.size.height);
        } completion:nil];
        interal+=0.1;
    }
    [UIView animateWithDuration:0.2 animations:^{
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.effect=blur;
    }];
}


-(void)click:(UIButton*)btn
{
    if(_delegate && [_delegate respondsToSelector:@selector(ChooseIndex:Index:Text:)])
    {
        [_delegate ChooseIndex:self Index:btn.tag Text:[btn titleForState:UIControlStateNormal]];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.tag==1)
    {
        return;
    }
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}
@end









