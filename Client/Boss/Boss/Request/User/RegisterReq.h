//
//  RegisterReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface RegisterReq : BaseReq<POST>
@property (strong,nonatomic) NSString* name;
@property (assign,nonatomic) NSInteger age;
@property (strong,nonatomic) NSString* sex;
@property (strong,nonatomic) NSString* question;
@property (strong,nonatomic) NSString* answer;
@end
