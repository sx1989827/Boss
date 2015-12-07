//
//  UserDefaults.m
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "UserDefaults.h"
#import "Header.h"
@interface UserDefaults()
@property (strong,nonatomic)    NSMutableDictionary *dicPeople;
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
        obj.dicPeople=[[NSMutableDictionary alloc] initWithCapacity:30];
        obj.dicPower=[[NSMutableDictionary alloc] initWithCapacity:30];
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

-(void)updatePeopleInfo:(void (^)(NSDictionary *))block Hud:(BOOL)bHud
{
	[PeopleInfoReq do:^(id req) {
        
    } Res:^(id res) {
        PeopleInfoRes *obj=res;
        if(obj.code==0)
        {
            NSArray* arr= obj.data;
            for(PeopleInfoModel *model in arr)
            {
                [_dicPeople setObject:model forKey:model.name];
            }
            if(block)
            {
                block(_dicPeople);
            }
        }
        else
        {
            E(obj.msg);
        }
    } ShowHud:bHud];
}

-(PeopleInfoModel *)peopleName:(NSString*)name
{
    return _dicPeople[name];
}

-(void)updatePowerInfo:(void (^)(NSDictionary* dic))block Hud:(BOOL)bHud
{
    [PowerInfoReq do:^(id req) {
        
    } Res:^(id res) {
        PowerInfoRes *obj=res;
        if(obj.code==0)
        {
            NSArray* arr= obj.data;
            for(PowerInfoModel *model in arr)
            {
                [_dicPower setObject:@(model.value) forKey:model.name];
            }
            if(block)
            {
                block(_dicPower);
            }
        }
        else
        {
            E(obj.msg);
        }
    } ShowHud:bHud];
}

-(NSInteger)powerName:(NSString*)name
{
    return [_dicPower[name] integerValue];
}

-(NSString*)level:(NSString*)type
{
	for(UserInfoLevelModel *obj in _resModel.data.level)
    {
        if([obj.name isEqualToString:type])
        {
            return obj.level;
        }
    }
    return nil;
}

-(void)updateScore:(NSInteger)score
{
	self.resModel.data.score=score;
}

-(void)updateLevel:(NSString*)type Level:(NSString*)level
{
    
    for(UserInfoLevelModel *obj in _resModel.data.level)
    {
        if([obj.name isEqualToString:type])
        {
            obj.level=level;
            return;
        }
    }
    NSMutableArray<UserInfoLevelModel> *arr=[[NSMutableArray<UserInfoLevelModel> alloc] initWithArray:_resModel.data.level];
    UserInfoLevelModel *obj=[[UserInfoLevelModel alloc] init];
    obj.name=type;
    obj.level=level;
    [arr addObject:obj];
    _resModel.data.level=arr;
}

-(NSInteger)money:(NSString*)levelName
{
    return [self peopleName:levelName].money;
}

@end







