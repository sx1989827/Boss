//
//  EditPhotoReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/25.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"

@interface EditPhotoReq : BaseReq<POST>
@property (strong,nonatomic) NSData* file;
@end

@interface EditPhotoRes : BaseRes
@property (strong,nonatomic) NSString<Optional>* data;
@end
