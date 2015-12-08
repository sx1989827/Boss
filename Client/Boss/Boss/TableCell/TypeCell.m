//
//  TypeCell.m
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "TypeCell.h"
#import "TypeItem.h"
#import "Header.h"
@implementation TypeCell

-(NSNumber*)LazyTableCellHeight:(id)item Path:(NSIndexPath *)path
{
    return @80;
}

-(void)LazyTableCellForRowAtIndexPath:(id)item Path:(NSIndexPath *)path
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    TypeItem *data=item;
    _lbTitle.text=data.name;
}

-(void)LazyTableCellDidSelect:(id)item Path:(NSIndexPath *)path
{
    TypeItem *data=item;
    UIViewController *vc=(UIViewController*)data.viewControllerDelegate;
    [vc pushViewController:@"LevelVC" Param:@{@"type":data.name}];
    UIImage *img=[self.contentView image];
    CGRect frame=[self.contentView convertRect:self.contentView.bounds toView:[UIApplication sharedApplication].keyWindow];
    UIImageView *view=[[UIImageView alloc] initWithImage:img];
    view.frame=frame;
    view.layer.zPosition=FLT_MAX;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView animateWithDuration:0.2 animations:^{
        view.frame=CGRectInset(view.frame, -20, -30);
        view.alpha=0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

@end








