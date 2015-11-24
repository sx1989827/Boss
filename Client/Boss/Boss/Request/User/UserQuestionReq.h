//
//  UserQuestionReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface UserQuestionReq : BaseReq<GET>

@end

@interface UserQuestionRes : BaseRes
@property (strong,nonatomic) NSString<Optional>* data;
@end
