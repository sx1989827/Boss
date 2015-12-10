//
//  HistoryItem.h
//  Boss
//
//  Created by libruce on 15/12/8.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LazyTableBaseItem.h"
@interface HistoryItem : LazyTableBaseItem
@property(nonatomic,strong)NSString  *type;
@property(nonatomic,strong)NSString  *createtime;
@property(nonatomic,strong)NSString  *usetime;
@property(nonatomic,strong)NSString *percent;
@property(nonatomic,strong)NSArray  *item;
@property(nonatomic,strong)NSString  *level;

@end
