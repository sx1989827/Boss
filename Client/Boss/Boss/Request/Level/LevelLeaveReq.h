//
//  LevelLeaveReq.h
//  Boss
//
//  Created by 孙昕 on 15/12/6.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface LevelLeaveReq : BaseReq<POST>
@property (strong,nonatomic) NSString* type;
@property (strong,nonatomic) NSString* level;
@property (assign,nonatomic) NSInteger success;
@property (strong,nonatomic) NSString* createtime;
@property (strong,nonatomic) NSString* usetime;
@property (assign,nonatomic) float percent;
@property (assign,nonatomic) NSInteger score;
@property (strong,nonatomic) NSString* item;
@end

@interface LevelLeaveModel : JSONModel
@property (assign,nonatomic) NSInteger score;
@property (strong,nonatomic) NSString* level;
@end

@interface LevelLeaveRes : BaseRes
@property (strong,nonatomic) LevelLeaveModel<Optional> *data;
@end









