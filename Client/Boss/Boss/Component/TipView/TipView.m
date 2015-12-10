//
//  TipView.m
//  Boss
//
//  Created by 孙昕 on 15/11/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "TipView.h"
enum Style
{
    ALERT,PROMPT
};
@interface TipView()
typedef void (^BLOCK)() ;
@property (strong,nonatomic)    UIView *viewContent;
@property (strong,nonatomic)     UILabel *lbTitle;
@property (strong,nonatomic)    UILabel *lbText;
@property (strong,nonatomic)    UIButton *btnYes;
@property (strong,nonatomic)    UIButton *btnNo;
@property (strong,nonatomic)   BLOCK blkYes;
@property (strong,nonatomic)   BLOCK blkNo;
@property (assign,nonatomic) Style style;
@end
@implementation TipView
-(instancetype)initWithFrame:(CGRect)frame Style:(Style)style
{
    if(self=[super initWithFrame:frame])
    {
        _style=style;
        
        _viewContent=[[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, [UIScreen mainScreen].bounds.size.height, 300, 170)];
        _viewContent.backgroundColor=[UIColor whiteColor];
        _viewContent.layer.masksToBounds=YES;
        _viewContent.layer.borderWidth=1;
        _viewContent.layer.cornerRadius=5;
        _viewContent.layer.borderColor=[UIColor colorWithRed:0.133 green:0.200 blue:0.239 alpha:1.000].CGColor;
        _lbTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, _viewContent.bounds.size.width, 40)];
        _lbTitle.translatesAutoresizingMaskIntoConstraints=NO;
        _lbTitle.textAlignment=NSTextAlignmentCenter;
        _lbTitle.textColor=[UIColor whiteColor];
        _lbTitle.backgroundColor=[UIColor colorWithRed:0.133 green:0.200 blue:0.239 alpha:1.000];
        _viewContent.translatesAutoresizingMaskIntoConstraints=NO;
        [_viewContent addSubview:_lbTitle];
        [_viewContent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_lbTitle]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lbTitle)]];
        [_viewContent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_lbTitle(==40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lbTitle)]];
        _lbText=[[UILabel alloc] initWithFrame:CGRectMake(10, 60, _viewContent.bounds.size.width-20, 40)];
        _lbText.numberOfLines=0;
        _lbText.font=[UIFont systemFontOfSize:17];
        _lbText.lineBreakMode=NSLineBreakByCharWrapping;
        _lbText.textAlignment=NSTextAlignmentCenter;
        _lbText.translatesAutoresizingMaskIntoConstraints=NO;
        [_viewContent addSubview:_lbText];
        [_viewContent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_lbText]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lbText)]];
        [_viewContent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lbTitle]-20-[_lbText(>=40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lbTitle,_lbText)]];
        if(_style==ALERT)
        {
            _btnYes=[[UIButton alloc] initWithFrame:CGRectZero];
            [_btnYes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_btnYes setTitle:@"OK" forState:UIControlStateNormal];
            _btnYes.titleLabel.font=[UIFont systemFontOfSize:20];
            [_btnYes setBackgroundColor:[UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000]];
            _btnYes.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
            _btnYes.layer.masksToBounds=YES;
            _btnYes.layer.cornerRadius=5;
            _btnYes.translatesAutoresizingMaskIntoConstraints=NO;
            [_viewContent addSubview:_btnYes];
            [_viewContent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_btnYes]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnYes)]];
            [_viewContent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lbText]-20-[_btnYes(==40)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lbText,_btnYes)]];
        }
        else
        {
            _btnYes=[[UIButton alloc] initWithFrame:CGRectZero];
            [_btnYes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_btnYes setTitle:@"YES" forState:UIControlStateNormal];
            _btnYes.titleLabel.font=[UIFont systemFontOfSize:20];
            [_btnYes setBackgroundColor:[UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000]];
            _btnYes.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
            _btnYes.layer.masksToBounds=YES;
            _btnYes.layer.cornerRadius=5;
            _btnYes.translatesAutoresizingMaskIntoConstraints=NO;
            [_viewContent addSubview:_btnYes];
            [_btnYes addConstraint:[NSLayoutConstraint constraintWithItem:_btnYes attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:120]];
            [_viewContent addConstraint:[NSLayoutConstraint constraintWithItem:_btnYes attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_viewContent attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
            [_viewContent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lbText]-20-[_btnYes(==40)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lbText,_btnYes)]];
            _btnNo=[[UIButton alloc] initWithFrame:CGRectZero];
            [_btnNo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_btnNo setTitle:@"NO" forState:UIControlStateNormal];
            _btnNo.titleLabel.font=[UIFont systemFontOfSize:20];
            [_btnNo setBackgroundColor:[UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000]];
            _btnNo.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
            _btnNo.layer.masksToBounds=YES;
            _btnNo.layer.cornerRadius=5;
            _btnNo.translatesAutoresizingMaskIntoConstraints=NO;
            [_viewContent addSubview:_btnNo];
            [_btnNo addConstraint:[NSLayoutConstraint constraintWithItem:_btnNo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:120]];
            [_viewContent addConstraint:[NSLayoutConstraint constraintWithItem:_btnNo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_viewContent attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0]];
            [_viewContent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lbText]-20-[_btnNo(==40)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lbText,_btnNo)]];
        }
        _viewContent.translatesAutoresizingMaskIntoConstraints=NO;
        [self.contentView addSubview:_viewContent];
        UIView *view=self.contentView;
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_viewContent]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_viewContent)]];
        
    }
    return self;
}

+(void)showWithTitle:(NSString*)title Tip:(NSString*)text Block:(void (^)())block
{
    TipView *view=[[TipView alloc] initWithFrame:[UIScreen mainScreen].bounds Style:(Style)ALERT];
    view.lbTitle.text=title;
    view.lbText.text=text;
    [view.btnYes addTarget:view action:@selector(onYes) forControlEvents:UIControlEventTouchUpInside];
    view.blkYes=block;
    [view layoutIfNeeded];
    view.viewContent.translatesAutoresizingMaskIntoConstraints=YES;
    view.viewContent.center=CGPointMake([UIApplication sharedApplication].keyWindow.center.x, -view.viewContent.bounds.size.height/2);
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView animateWithDuration:0.2 animations:^{
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        view.effect=blur;
    }];
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:15 options:0 animations:^{
        view.viewContent.center=[UIApplication sharedApplication].keyWindow.center ;
    } completion:^(BOOL finished) {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(view.viewContent.center.x-60, view.viewContent.frame.origin.y-110, 120, 120)];
        UIImageView *imgLeft=[[UIImageView alloc] initWithFrame:CGRectMake(view.viewContent.frame.origin.x+10, view.viewContent.frame.origin.y-10, 20, 20)];
        imgLeft.image=[UIImage imageNamed:@"AlertLeft.png"];
        [view.contentView addSubview:imgLeft];
        UIImageView *imgRight=[[UIImageView alloc] initWithFrame:CGRectMake(view.viewContent.frame.origin.x+view.viewContent.frame.size.width-30, view.viewContent.frame.origin.y-10, 20, 20)];
        imgRight.image=[UIImage imageNamed:@"AlertRight.png"];
        [view.contentView addSubview:imgRight];
        imgView.image=[UIImage imageNamed:@"AlertStatus.png"];
        [view.contentView addSubview:imgView];
        [view.contentView sendSubviewToBack:imgView];
    }];
}

+(void)showWithTitle:(NSString*)title Tip:(NSString*)text YesBlock:(void (^)())blockYes  NoBlock:(void (^)())blockNo
{
    TipView *view=[[TipView alloc] initWithFrame:[UIScreen mainScreen].bounds Style:(Style)PROMPT];
    view.lbTitle.text=title;
    view.lbText.text=text;
    [view.btnYes addTarget:view action:@selector(onYes) forControlEvents:UIControlEventTouchUpInside];
    [view.btnNo addTarget:view action:@selector(onNo) forControlEvents:UIControlEventTouchUpInside];
    view.blkYes=blockYes;
    view.blkNo=blockNo;
    [view layoutIfNeeded];
    view.viewContent.center=CGPointMake([UIApplication sharedApplication].keyWindow.center.x, -view.viewContent.bounds.size.height/2);
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView animateWithDuration:0.2 animations:^{
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        view.effect=blur;
    }];
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:15 options:0 animations:^{
        view.viewContent.translatesAutoresizingMaskIntoConstraints=YES;
        view.viewContent.center=[UIApplication sharedApplication].keyWindow.center ;
    } completion:^(BOOL finished) {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(view.viewContent.center.x-60, view.viewContent.frame.origin.y-110, 120, 120)];
        UIImageView *imgLeft=[[UIImageView alloc] initWithFrame:CGRectMake(view.viewContent.frame.origin.x+10, view.viewContent.frame.origin.y-10, 20, 20)];
        imgLeft.image=[UIImage imageNamed:@"AlertLeft.png"];
        [view.contentView addSubview:imgLeft];
        UIImageView *imgRight=[[UIImageView alloc] initWithFrame:CGRectMake(view.viewContent.frame.origin.x+view.viewContent.frame.size.width-30, view.viewContent.frame.origin.y-10, 20, 20)];
        imgRight.image=[UIImage imageNamed:@"AlertRight.png"];
        [view.contentView addSubview:imgRight];
        imgView.image=[UIImage imageNamed:@"AlertInfo.png"];
        [view.contentView addSubview:imgView];
        [view.contentView sendSubviewToBack:imgView];
    }];
}

-(void)onYes
{
    if(_blkYes)
    {
        _blkYes();
    }
        [UIView animateWithDuration:0.3 animations:^{
            self.effect=nil;
            self.contentView.alpha=0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

-(void)onNo
{
    if(_blkNo)
    {
        _blkNo();
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.effect=nil;
        self.contentView.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end







