//
//  ChooseItemCountView.m
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ChooseItemCountView.h"
#import "Header.h"
@implementation ChooseItemCountView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)onAdd:(id)sender
{
    BOOL ret=[_delegate ChooseItemCountAdd];
    if(ret)
    {
        _lbCount.text=[NSString stringWithFormat:@"%ld",[_lbCount.text integerValue]+1];
    }
    else
    {
        E(@"分配的步数不能大于总步数!");
    }
}

- (IBAction)onMinus:(id)sender
{
    if([_lbCount.text integerValue]==0)
    {
        return;
    }
    else
    {
        _lbCount.text=[NSString stringWithFormat:@"%ld",[_lbCount.text integerValue]-1];
    }
}
@end







