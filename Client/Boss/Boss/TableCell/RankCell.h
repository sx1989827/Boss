//
//  RankCell.h
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <LazyTableCell.h>

@interface RankCell : LazyTableCell
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UILabel *lbName;
@property (strong, nonatomic) IBOutlet UILabel *lbScore;

@end
