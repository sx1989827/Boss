//
//  HistoryCell.m
//  Boss
//
//  Created by libruce on 15/12/7.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "HistoryCell.h"
#import "percentView.h"
#import "HistoryItem.h"
#import "Header.h"
#import "TipView.h"
@implementation HistoryCell

-(NSNumber*)LazyTableCellHeight:(id)item Path:(NSIndexPath *)path
{
    return  @100;
}
-(void)LazyTableCellForRowAtIndexPath:(id)item Path:(NSIndexPath *)path
{
    HistoryItem*data =item;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.type.text =[NSString stringWithFormat:@"关卡名称:%@",data.level];
    self.useTime.text = [NSString stringWithFormat:@"用时:%@ s",data.usetime];
    self.creatTime.text = data.createtime;
    self.percentView.percent = [data.percent floatValue];
}
-(void)LazyTableCellDidSelect:(id)item Path:(NSIndexPath *)path
{
    HistoryItem*data = item;
    if([data.percent integerValue]==1)
    {
      [TipView showWithTitle: @"提示" Tip:@"您此关卡表现非常棒，没有错题!" Block:^{
      }];
    }
    else
    {
        UIViewController *vc=(UIViewController*)data.viewControllerDelegate;
        [vc pushViewController:@"WrongItemViewController" Param:@{@"item":data.item}];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)wrongQuestionArrayButtonClick:(id)sender {
    
    
    
}
@end
