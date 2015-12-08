//
//  EditPswReq.h
//  Boss
//
//  Created by libruce on 15/12/7.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface EditPswReq : BaseReq<PUT>
@property(nonatomic,strong)NSString *newpwd;
@end
