//
//  InputView.m
//  Boss
//
//  Created by 孙昕 on 15/11/25.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "InputView.h"
@interface InputView()
typedef BOOL (^BLOCK)(NSString*) ;
@property (strong,nonatomic)    UIView *viewContent;
@property (strong,nonatomic)     UILabel *lbTitle;
 @property (strong,nonatomic)    UITextField *texInput;
 @property (strong,nonatomic)    UIButton *btnConfirm;
@property (strong,nonatomic)   BLOCK blk;
@end
@implementation InputView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.effect=blur;
        _viewContent=[[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, [UIScreen mainScreen].bounds.size.height, 300, 170)];
        _viewContent.backgroundColor=[UIColor whiteColor];
        _viewContent.layer.masksToBounds=YES;
        _viewContent.layer.borderWidth=1;
        _viewContent.layer.cornerRadius=5;
        _viewContent.layer.borderColor=[UIColor colorWithRed:0.133 green:0.200 blue:0.239 alpha:1.000].CGColor;
        _lbTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, _viewContent.bounds.size.width, 40)];
        _lbTitle.textAlignment=NSTextAlignmentCenter;
        _lbTitle.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin;
        _lbTitle.textColor=[UIColor whiteColor];
        _lbTitle.backgroundColor=[UIColor colorWithRed:0.133 green:0.200 blue:0.239 alpha:1.000];
        [_viewContent addSubview:_lbTitle];
        _texInput=[[UITextField alloc] initWithFrame:CGRectMake(10, 60, _viewContent.bounds.size.width-20, 40)];
        _texInput.borderStyle=UITextBorderStyleNone;
        _texInput.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin;
        [_viewContent addSubview:_texInput];
        _btnConfirm=[[UIButton alloc] initWithFrame:CGRectMake(20, 120, _viewContent.bounds.size.width-40, 40)];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font=[UIFont systemFontOfSize:20];
        [_btnConfirm setBackgroundColor:[UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000]];
        _btnConfirm.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        _btnConfirm.layer.masksToBounds=YES;
        _btnConfirm.layer.cornerRadius=5;
        [_viewContent addSubview:_btnConfirm];
        [self.contentView addSubview:_viewContent];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint p=[touch locationInView:self];
    if(!CGRectContainsPoint(_viewContent.frame, p))
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

+(void)showWithTitle:(NSString*)title TextPlaceHolder:(NSString*)placeholder Block:(BOOL (^)(NSString *text))block
{
    InputView *view=[[InputView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.lbTitle.text=title;
    view.texInput.placeholder=placeholder;
    [view.btnConfirm addTarget:view action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
    view.blk=block;
    view.alpha=0;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha=1;
    }];
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:15 options:0 animations:^{
        view.viewContent.center=CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y-100) ;
    } completion:nil];
}

-(void)onConfirm
{
    BOOL ret=_blk(_texInput.text);
    if(ret)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }

}
@end






