//
//  EnemyCell.h
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <LazyTableCell.h>

@interface EnemyCell : LazyTableCell
@property (strong, nonatomic) IBOutlet UILabel *lbName;
@property (strong, nonatomic) IBOutlet UILabel *lbCount;
@property (strong, nonatomic) IBOutlet UILabel *lbDes;

@end
