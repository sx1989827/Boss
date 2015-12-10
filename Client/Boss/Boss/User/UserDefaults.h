//
//  UserDefaults.h
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoReq.h"
#import "PeopleInfoReq.h"
#import "PowerInfoReq.h"
@interface UserDefaults : NSObject
@property (strong,nonatomic) UserInfoRes *resModel;
@property (strong,nonatomic)    NSMutableDictionary *dicPower;
-(NSString*)level:(NSString*)type;
-(NSInteger)money:(NSString*)levelName;
-(BOOL)isFirstLogin;
+(instancetype)sharedInstance;
-(BOOL)isAvailable;
-(void)update:(NSString*)username Pwd:(NSString*)pwd SucBlock:(void (^)(UserInfoModel* model))sucBlock FailBlock:(void (^)(NSString* msg))failBlock  Hud:(BOOL)bHud;
-(void)updatePeopleInfo:(void (^)(NSDictionary* dic))block Hud:(BOOL)bHud;
-(PeopleInfoModel *)peopleName:(NSString*)name;
-(void)updatePowerInfo:(void (^)(NSDictionary* dic))block Hud:(BOOL)bHud;
-(NSInteger)powerName:(NSString*)name;
-(void)updateScore:(NSInteger)score;
-(void)updateLevel:(NSString*)type Level:(NSString*)level;
-(BOOL)isFirstLoadVC:(NSString*)vc;
@end





