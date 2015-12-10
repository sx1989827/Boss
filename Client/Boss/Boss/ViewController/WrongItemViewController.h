//
//  WrongItemViewController.h
//  Boss
//
//  Created by libruce on 15/12/10.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"
#import <LazyTableView.h>
@interface WrongItemViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong)NSArray  *item;
@end
