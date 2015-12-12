//
//  ItemView.m
//  Boss
//
//  Created by 孙昕 on 15/12/5.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ItemView.h"
@interface ItemView()
{
    __weak NSMutableAttributedString* curStr;
    NSInteger curStart;
    NSInteger curLen;
    NSInteger finishCount;
    NSArray *arr;
}
@end
@implementation ItemView

-(void)addItem:(NSString*)text Flag:(NSString *)flag
{
    [self clear];
    [self setDrawInset:10 Top:10];
    arr=[text componentsSeparatedByString:flag];
    finishCount=0;
    NSInteger index=0;
    for(int i=0;i<arr.count;i++)
    {
        [self addText:arr[i] Style:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} ClickBlock:nil];
        if(i==arr.count-1)
        {
            break;
        }
        __weak ItemView* weakSelf=self;
        [self addText:flag Style:@{NSFontAttributeName:[UIFont systemFontOfSize:20],@"index":@(index++)} ClickBlock:^BOOL(NSMutableAttributedString *str, NSInteger start, NSInteger len) {
            curStr=str;
            curStart=start;
            curLen=len;
            [weakSelf click];
            return NO;
        }];
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

-(void)setOK:(BOOL)bOk Text:(NSString *)text
{
    if(bOk)
    {
        [curStr addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(curStart, curLen)];
    }
    else
    {
        [curStr addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(curStart, curLen)];
    }
    [curStr removeAttribute:NSUnderlineStyleAttributeName range:NSMakeRange(curStart, curLen)];
    [curStr removeAttribute:@"click" range:NSMakeRange(curStart, curLen)];
    [curStr replaceCharactersInRange:NSMakeRange(curStart, curLen) withString:text];
    [self setNeedsLayout];
    [self setNeedsDisplay];
    finishCount++;
    if(finishCount==arr.count-1 || !bOk)
    {
        if(_delegate && [_delegate respondsToSelector:@selector(finishQuestion)])
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_delegate finishQuestion];
            });
        }
    }
}


-(void)click
{
    if(_delegate && [_delegate respondsToSelector:@selector(clickQuestion:)])
    {
        [_delegate clickQuestion:[[curStr attribute:@"index" atIndex:curStart effectiveRange:nil] integerValue]];
    }
}
@end








