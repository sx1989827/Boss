//
//  DeleteHistoryReq.h
//  Boss
//
//  Created by libruce on 15/12/12.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface DeleteHistoryReq : BaseReq<DELETE>
@property(nonatomic,strong)NSString *type;
@end
@interface DeleteHistoryRes : BaseRes
@property (strong,nonatomic) NSString<Optional>* data;
@end
