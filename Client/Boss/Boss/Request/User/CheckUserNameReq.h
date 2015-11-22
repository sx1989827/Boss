//
//  CheckUserNameReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/20.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface CheckUserNameReq : BaseReq<GET>

@end

@interface CheckUserNameRes : BaseRes
@property (assign,nonatomic) NSInteger data;
@end
