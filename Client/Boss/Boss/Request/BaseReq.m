


//  BaseReq.m
//  Boss
//
//  Created by 孙昕 on 15/11/20.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseReq.h"
#import <objc/runtime.h>
#import "Header.h"
@implementation BaseReq
+(NSMutableDictionary *)copyPropertyList:(id)obj
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:30];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    for (i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString * key = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        if([obj valueForKey:key]!=nil)
        {
            if(![[obj valueForKey:key] isKindOfClass:[NSData class]])
            {
                [dic setObject:[obj valueForKey:key] forKey:key];
            }
            else
            {
                NSMutableArray *arr=[dic objectForKey:@"#FileAppendName"];
                if(arr==nil)
                {
                    arr=[[NSMutableArray alloc] initWithCapacity:30];
                    [dic setObject:arr forKey:@"#FileAppendName"];
                }
                [arr addObject:key];
            }
        }
    }
    properties = class_copyPropertyList([[obj class] superclass], &outCount);
    for (i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString * key = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        if([obj valueForKey:key]!=nil)
        {
            if(![key isEqualToString:@"url"])
            {
                [dic setObject:[obj valueForKey:key] forKey:key];
            }
        }
    }
    
    return dic;
}

+(void)do:(void (^)(id req))reqBlock Res:(void (^)(id res))resBlock ShowHud:(BOOL)bHud
{
    BaseReq* ret=[[[self class] alloc] init];
    if([[UserDefaults sharedInstance] isAvailable])
    {
        ret.username=[UserDefaults sharedInstance].resModel.data.username;
        ret.pwd=[UserDefaults sharedInstance].resModel.data.pwd;
    }
    reqBlock(ret);
    NSString *strCls=NSStringFromClass([ret class]);
    strCls=[strCls stringByReplacingOccurrencesOfString:@"Req" withString:@"Res"];
    NSMutableDictionary *dic=[BaseReq copyPropertyList:ret];
    if([ret conformsToProtocol:@protocol(GET)])
    {
        [Util getWithUrl:[ret valueForKey:@"url"] withParams:dic SuccessBlock:^(NSDictionary *dic) {
            Class cls=NSClassFromString(strCls);
            if(cls==nil)
            {
                cls=[BaseRes class];
            }
            NSError *err;
            id data=[[cls alloc] initWithDictionary:dic error:&err];
            if(data==nil)
            {
                E(@"网络数据发生异常");
                return;
            }
            if(resBlock)
            {
                resBlock(data);
            }
        } FailBlock:^(NSError *error) {
            E(@"网络连接发生错误");
        } ShowHud:bHud];
    }
    else if([ret conformsToProtocol:@protocol(POST)])
    {
        NSMutableArray *arr=[dic objectForKey:@"#FileAppendName"];
        if(arr!=nil)
        {
            [dic removeObjectForKey:@"#FileAppendName"];
            [Util postWithUrl:[ret valueForKey:@"url"] withParams:dic BodyBlock:^(id<AFMultipartFormData> formData) {
                for(NSString *key in arr)
                {
                    NSData *data=[ret valueForKey:key];
                    [formData appendPartWithFileData:data name:key fileName:key mimeType:@"image/png"];
                }
            } SuccessBlock:^(NSDictionary *dic) {
                Class cls=NSClassFromString(strCls);
                if(cls==nil)
                {
                    cls=[BaseRes class];
                }
                NSError *err;
                id data=[[cls alloc] initWithDictionary:dic error:&err];
                if(data==nil)
                {
                    E(@"网络数据发生异常");
                    return;
                }
                if(resBlock)
                {
                    resBlock(data);
                }
            } FailBlock:^(NSError *error) {
                E(@"网络连接发生错误");
            } ShowHud:bHud];
        }
        else
        {
            [Util postWithUrl:[ret valueForKey:@"url"] withParams:dic SuccessBlock:^(NSDictionary *dic) {
                Class cls=NSClassFromString(strCls);
                if(cls==nil)
                {
                    cls=[BaseRes class];
                }
                NSError *err;
                id data=[[cls alloc] initWithDictionary:dic error:&err];
                if(data==nil)
                {
                    E(@"网络数据发生异常");
                    return;
                }
                if(resBlock)
                {
                    resBlock(data);
                }
            } FailBlock:^(NSError *error) {
                E(@"网络连接发生错误");
            } ShowHud:bHud];
        }
        
    }
    else if([ret conformsToProtocol:@protocol(PUT)])
    {
        
        [Util putWithUrl:[ret valueForKey:@"url"] withParams:dic SuccessBlock:^(NSDictionary *dic) {
            Class cls=NSClassFromString(strCls);
            if(cls==nil)
            {
                cls=[BaseRes class];
            }
            NSError *err;
            id data=[[cls alloc] initWithDictionary:dic error:&err];
            if(data==nil)
            {
                E(@"网络数据发生异常");
                return;
            }
            if(resBlock)
            {
                resBlock(data);
            }
        } FailBlock:^(NSError *error) {
            E(@"网络连接发生错误");
        } ShowHud:bHud];
    }
    else if([ret conformsToProtocol:@protocol(DELETE)])
    {
        [Util deleteWithUrl:[ret valueForKey:@"url"] withParams:dic SuccessBlock:^(NSDictionary *dic) {
            Class cls=NSClassFromString(strCls);
            if(cls==nil)
            {
                cls=[BaseRes class];
            }
            NSError *err;
            id data=[[cls alloc] initWithDictionary:dic error:&err];
            if(data==nil)
            {
                E(@"网络数据发生异常");
                return;
            }
            if(resBlock)
            {
                resBlock(data);
            }
        } FailBlock:^(NSError *error) {
            E(@"网络连接发生错误");
        } ShowHud:bHud];
    }
}
@end

@implementation BaseRes

@end






