//
//  PowerInfoReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface PowerInfoReq : BaseReq<GET>

@end

@interface PowerInfoModel : JSONModel
@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) NSInteger value;
@end

@protocol PowerInfoModel <NSObject>

@end

@interface PowerInfoRes : BaseRes
@property (strong,nonatomic) NSArray<PowerInfoModel,Optional> *data;
@end








