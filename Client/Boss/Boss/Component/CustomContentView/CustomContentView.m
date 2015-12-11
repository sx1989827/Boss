//
//  CustomContentView.m
//  Boss
//
//  Created by libruce on 15/12/11.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "CustomContentView.h"

@implementation CustomContentView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _contentTextView = [[UITextView alloc]init];
        _contentTextView.font = [UIFont systemFontOfSize:17];
        _contentTextView.userInteractionEnabled =NO;
        _contentTextView.backgroundColor = [UIColor grayColor];
        [self addSubview:_contentTextView];
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
