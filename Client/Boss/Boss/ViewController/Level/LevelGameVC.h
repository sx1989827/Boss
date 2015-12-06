//
//  LevelGameVC.h
//  Boss
//
//  Created by 孙昕 on 15/12/4.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"
#import "LevelStartReq.h"
#import "ItemView.h"
@interface LevelGameVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIScrollView *viewScroll;
@property (strong, nonatomic) IBOutlet ItemView *viewItem;

@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *level;
@property (strong,nonatomic) NSDictionary* dicEnemy;
@property (assign,nonatomic) NSInteger powerCount;
@property (assign,nonatomic) NSInteger time;
@property (strong,nonatomic) NSArray<LevelStartModel*> *arrItem;
@end
