//
//  UserDefaults.h
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoReq.h"
@interface UserDefaults : NSObject
@property (strong,nonatomic) UserInfoRes *resModel;
+(instancetype)sharedInstance;
-(BOOL)isAvailable;
-(void)update:(NSString*)username Pwd:(NSString*)pwd SucBlock:(void (^)(UserInfoModel* model))sucBlock FailBlock:(void (^)(NSString* msg))failBlock  Hud:(BOOL)bHud;
@end
