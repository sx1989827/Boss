//
//  EnemyCell.m
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "EnemyCell.h"
#import "EnemyItem.h"
@implementation EnemyCell
-(NSNumber*)LazyTableCellHeight:(id)item Path:(NSIndexPath *)path
{
    EnemyItem *data=item;
    _lbDes.preferredMaxLayoutWidth=data.tableViewDelegate.frame.size.width-198;
    _lbDes.text=data.des;
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return @(1+ size.height);
}

-(void)LazyTableCellForRowAtIndexPath:(id)item Path:(NSIndexPath *)path
{
    EnemyItem *data=item;
    _lbName.text=data.name;
    _lbCount.text=[NSString stringWithFormat:@"X%ld",data.count];
    _lbDes.text=data.des;
}

@end







