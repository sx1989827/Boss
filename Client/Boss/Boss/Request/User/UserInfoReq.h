//
//  UserInfoReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface UserInfoReq : BaseReq<GET>

@end

@interface UserInfoLevelModel : JSONModel<NSCoding>
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* level;
@end

@protocol UserInfoLevelModel <NSObject>

@end

@interface UserInfoModel : JSONModel<NSCoding>
@property (strong,nonatomic) NSString* username;
@property (strong,nonatomic) NSString* pwd;
@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) NSInteger age;
@property (strong,nonatomic) NSString* sex;
@property (strong,nonatomic) NSString* question;
@property (strong,nonatomic) NSString* answer;
@property (strong,nonatomic) NSString* photo;
@property (assign,nonatomic) NSInteger score;
@property (strong,nonatomic) NSArray<UserInfoLevelModel>* level;
@end

@interface UserInfoRes : BaseRes<NSCoding>
@property (strong,nonatomic) UserInfoModel<Optional> *data;
@end





