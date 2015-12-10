//
//  WrongItem.h
//  Boss
//
//  Created by libruce on 15/12/10.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <LazyTableView/LazyTableView.h>
#import <LazyTableBaseItem.h>
@interface WrongItem : LazyTableBaseItem
@property(nonatomic,strong)NSString *question;
@property(nonatomic,strong)NSString *answer;
@end
