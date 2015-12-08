//
//  MemberVC.h
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"
#import <LazyTableView.h>
@interface MemberVC : BaseViewController<LazyTableViewDelegate>
@property (strong, nonatomic) IBOutlet LazyTableView *tableMain;
@property (strong, nonatomic) IBOutlet UIButton *btnPhoto;
- (IBAction)onPhoto:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnName;
@property (strong, nonatomic) NSString *passWord;
@property (strong, nonatomic) NSArray  *typeArray;
- (IBAction)onName:(id)sender;

@end
