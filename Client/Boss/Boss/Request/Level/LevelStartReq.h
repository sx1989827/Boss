//
//  LevelStartReq.h
//  Boss
//
//  Created by 孙昕 on 15/12/4.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface LevelStartReq : BaseReq<GET>
@property (strong,nonatomic) NSString* type;
@property (strong,nonatomic) NSString* level;
@property (strong,nonatomic) NSString* power;
@end

@protocol LevelStartAnswer <NSObject>
@end

@protocol LevelStartData <NSObject>
@end

@protocol LevelStartModel <NSObject>
@end

@protocol NSString <NSObject>
@end

@interface LevelStartAnswer:JSONModel
@property (strong,nonatomic) NSString* ok;
@property (strong,nonatomic) NSArray* wrong;
@end

@interface LevelStartData:JSONModel
@property (strong,nonatomic) NSString* _id;
@property (strong,nonatomic) NSString* power;
@property (strong,nonatomic) NSString* content;
@property (strong,nonatomic) NSArray<LevelStartAnswer>* answer;
@end

@interface LevelStartModel:JSONModel
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSNumber<Ignore>* index;
@property (strong,nonatomic) NSArray<LevelStartData>* data;
@end

@interface LevelStartRes : BaseRes
@property (strong,nonatomic) NSArray<Optional,LevelStartModel> *data;
@end





