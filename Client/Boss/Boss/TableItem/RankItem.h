//
//  RankItem.h
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <LazyTableBaseItem.h>
@interface RankItem : LazyTableBaseItem
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* photo;
@property (assign,nonatomic) NSInteger score;
@end
