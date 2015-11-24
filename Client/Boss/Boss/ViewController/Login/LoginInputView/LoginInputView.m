//
//  LoginInputView.m
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "LoginInputView.h"
@interface LoginInputView()
{
    UIImageView *viewImg;
    UILabel *lbTitle;
}
@end
@implementation LoginInputView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        viewImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        viewImg.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        viewImg.contentMode=UIViewContentModeCenter;
        [self addSubview:viewImg];
        lbTitle=[[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
        lbTitle.textColor=[UIColor blackColor];
        lbTitle.font=[UIFont systemFontOfSize:14];
        [self addSubview:lbTitle];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    lbTitle.text=title;
}

-(void)setImgName:(NSString *)imgName
{
    viewImg.image=[UIImage imageNamed:imgName];
}
@end






