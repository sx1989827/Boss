//
//  TypeReq.h
//  Boss
//
//  Created by libruce on 15/12/8.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReq.h"
@interface TypeReq : BaseReq<GET>

@end
@interface TypeModel : JSONModel
@property(nonatomic,strong)NSString *name;
@end
@protocol TypeModel <NSObject>

@end
@interface TypeRes : BaseRes
@property(strong,nonatomic)NSArray<TypeModel,Optional>*data;
@end