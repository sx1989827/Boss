//
//  WrongReq.h
//  Boss
//
//  Created by libruce on 15/12/10.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface WrongModel : JSONModel
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSArray *answer;
@property(nonatomic,strong)NSString *power;
@property(nonatomic,strong)NSString  *_id;
@end
@protocol WrongModel <NSObject>
@end
@interface WrongReq : BaseReq<GET>
@property(nonatomic,strong)NSString *item;
@end
@interface WrongRes : BaseRes
@property(nonatomic,strong)NSArray<WrongModel,Optional>*data;
@end