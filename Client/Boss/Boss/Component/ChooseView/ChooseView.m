//
//  ChooseView.m
//  Boss
//
//  Created by 孙昕 on 15/12/6.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ChooseView.h"
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
    NSInteger gap=(self.bounds.size.height-30*arr.count)/(arr.count+1);
    NSInteger top=gap;
    float interal=0.2;
    for(int i=0;i<arr.count;i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag=i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame=CGRectMake(self.bounds.size.width, top, self.bounds.size.width-60, 30) ;
        btn.titleLabel.font=[UIFont systemFontOfSize:20];
        [btn setBackgroundColor:[UIColor colorWithRed:0.204 green:0.678 blue:0.988 alpha:1.000]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=5;
        top+=30+gap;
        [self.contentView addSubview:btn];
        [UIView animateWithDuration:0.2 delay:interal options:UIViewAnimationOptionCurveEaseOut animations:^{
            btn.frame=CGRectMake((self.bounds.size.width-btn.bounds.size.width)/2, btn.frame.origin.y, btn.bounds.size.width, btn.bounds.size.height);
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









