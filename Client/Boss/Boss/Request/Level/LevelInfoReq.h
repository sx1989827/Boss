//
//  LevelInfoReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface LevelInfoReq : BaseReq<GET>
@property (strong,nonatomic) NSString* type;
@end

@interface LevelInfoModel:JSONModel
@property (strong,nonatomic) NSString* level;
@property (assign,nonatomic) NSInteger score;
@property (strong,nonatomic) NSArray* totleLevel;
@end

@interface LevelInfoRes : BaseRes
@property (strong,nonatomic) LevelInfoModel<Optional>* data;
@end