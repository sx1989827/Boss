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

@implementation HistoryCell

-(NSNumber*)LazyTableCellHeight:(id)item Path:(NSIndexPath *)path
{
    
    return  @100;
    
}
-(void)LazyTableCellForRowAtIndexPath:(id)item Path:(NSIndexPath *)path
{
    HistoryItem*data =item;
    self.type.text =[NSString stringWithFormat:@"关卡名称:%@",data.type];
    self.useTime.text = [NSString stringWithFormat:@"用时:%@",data.date];
    self.percentView = [[PercentView alloc]init];
    self.percentView.percent = [data.percent floatValue];
}
-(void)LazyTableCellDidSelect:(id)item Path:(NSIndexPath *)path
{
    
    
    
    
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
