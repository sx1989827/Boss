//
//  RankVC.h
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"
#import <LazyTableView.h>
@interface RankVC : BaseViewController<LazyTableViewDelegate>
@property (strong, nonatomic) IBOutlet LazyTableView *tableMain;

@end
