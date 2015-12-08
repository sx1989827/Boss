//
//  LevelSetVC.h
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"
#import <LazyTableView.h>
@interface LevelSetVC : BaseViewController<LazyTableViewDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *conTableHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *conViewHeight;
@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet LazyTableView *tableMain;
@property (strong, nonatomic) IBOutlet UILabel *lbDes;
@property (strong, nonatomic) IBOutlet UIView *viewItem;
- (IBAction)onSubmit:(id)sender;
@property (strong,nonatomic) NSString* type;
@property (strong,nonatomic) NSString* level;
@property (assign,nonatomic) BOOL bChallenge;
@end
