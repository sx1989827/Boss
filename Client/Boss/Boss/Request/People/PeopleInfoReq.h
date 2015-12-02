//
//  PeopleInfoReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface PeopleInfoReq : BaseReq<GET>

@end

@interface PeopleInfoModel:JSONModel
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *talk;
@property (assign,nonatomic) NSInteger money;
@property (assign,nonatomic) float speed;
@property (strong,nonatomic) NSString *des;
@end

@protocol PeopleInfoModel <NSObject>

@end

@interface PeopleInfoRes : BaseRes
@property (strong,nonatomic) NSArray<PeopleInfoModel,Optional>* data;
@end








