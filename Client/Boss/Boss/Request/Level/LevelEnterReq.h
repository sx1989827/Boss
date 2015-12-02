//
//  LevelEnterReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface LevelEnterReq : BaseReq<GET>
@property (strong,nonatomic) NSString* type;
@property (strong,nonatomic ) NSString *level;
@end

@interface LevelEnterEnemy : JSONModel
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger count;
@end

@protocol LevelEnterEnemy <NSObject>
@end

@interface LevelEnterModel : JSONModel
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger time;
@property (assign,nonatomic) NSInteger step;
@property (strong,nonatomic) NSArray<LevelEnterEnemy> *enemy;
@end

@interface LevelEnterRes : BaseRes
@property (strong,nonatomic) LevelEnterModel<Optional> *data;
@end







