//
//  HistoryCell.h
//  Boss
//
//  Created by libruce on 15/12/7.
//  Copyright © 2015年 孙昕. All rights reserved.
//


#import <LazyTableCell.h>
#import "percentView.h"
@interface HistoryCell : LazyTableCell
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UILabel *useTime;
@property (strong, nonatomic) IBOutlet PercentView *percentView;
- (IBAction)wrongQuestionArrayButtonClick:(id)sender;

@end
