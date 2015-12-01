//
//  UserDefaults.m
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "UserDefaults.h"
@interface UserDefaults()

@end
@implementation UserDefaults


-(BOOL)isAvailable
{
	if(_resModel==nil)
    {
        return NO;
    }
    else if(_resModel.data==nil)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void)update:(NSString*)username Pwd:(NSString*)pwd SucBlock:(void (^)(UserInfoModel* model))sucBlock FailBlock:(void (^)(NSString* msg))failBlock  Hud:(BOOL)bHud
{
	[UserInfoReq do:^(id req) {
        UserInfoReq *obj=req;
        if(username!=nil)
        {
            obj.username=username;
            obj.pwd=pwd;
        }
        else
        {
            obj.username=_resModel.data.username;
            obj.pwd=_resModel.data.pwd;
        }
    } Res:^(id res) {
        UserInfoRes *obj=res;
        if(obj.code==0)
        {
            _resModel=obj;
            sucBlock(_resModel.data);
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_resModel];
            [user setObject:data forKey:@"userModel"];
            [user synchronize];
        }
        else
        {
            _resModel=nil;
            failBlock(obj.msg);
        }
    }  ShowHud:bHud];
}

+(instancetype)sharedInstance
{
    static UserDefaults *obj=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj=[[[self class] alloc] init];
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSData *data=[user objectForKey:@"userModel"];
        if(data)
        {
            UserInfoRes *res=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            obj.resModel=res;
        }
    });
    return obj;
}
@end







