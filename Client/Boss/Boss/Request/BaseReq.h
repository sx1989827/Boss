//
//  BaseReq.h
//  Boss
//
//  Created by 孙昕 on 15/11/20.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol GET
@end
@protocol POST
@end
@protocol PUT
@end
@protocol DELETE
@end
@interface BaseReq : JSONModel
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *pwd;
@property (strong,nonatomic) NSString *url;
+(void)do:(void (^)(id req))reqBlock Res:(void (^)(id res))resBlock  Err:(void (^)(NSError*))errBlock ShowHud:(BOOL)bHud;
@end

@interface BaseRes : JSONModel
@property (assign,nonatomic) NSInteger code;
@property (strong,nonatomic) NSString<Optional> *msg;
@end
