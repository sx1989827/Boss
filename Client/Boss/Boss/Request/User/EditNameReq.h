//
//  EditNameReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/25.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface EditNameReq : BaseReq<PUT>
@property (strong,nonatomic) NSString* name;
@end
