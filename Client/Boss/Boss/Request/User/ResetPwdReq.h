//
//  ResetPwd.h
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface ResetPwdReq : BaseReq<PUT>
@property (strong,nonatomic) NSString* answer;
@end
