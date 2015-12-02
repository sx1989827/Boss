//
//  EnemyItem.h
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <LazyTableBaseItem.h>

@interface EnemyItem : LazyTableBaseItem
@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) NSInteger count;
@property (strong,nonatomic) NSString *des;
@end
