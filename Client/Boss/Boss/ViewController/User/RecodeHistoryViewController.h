//
//  RecodeHistoryViewController.h
//  Boss
//
//  Created by libruce on 15/12/7.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"
#import <LazyTableView.h>
@interface RecodeHistoryViewController : BaseViewController
@property (strong, nonatomic) IBOutlet LazyTableView *mainTableView;
@property (strong, nonatomic) NSString *type;

@end
