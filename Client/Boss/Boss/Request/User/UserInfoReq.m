//
//  UserInfoReq.m
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "UserInfoReq.h"

@implementation UserInfoReq
-(NSString*)url
{
    return @"/user/info";
}
@end

@implementation UserInfoModel
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        _username=[aDecoder decodeObjectForKey:@"username"];
        _pwd=[aDecoder decodeObjectForKey:@"pwd"];
        _name=[aDecoder decodeObjectForKey:@"name"];
        _age=[[aDecoder decodeObjectForKey:@"age"] integerValue];
        _sex=[aDecoder decodeObjectForKey:@"sex"];
        _question=[aDecoder decodeObjectForKey:@"question"];
        _answer=[aDecoder decodeObjectForKey:@"answer"];
        _photo=[aDecoder decodeObjectForKey:@"photo"];
        _score=[[aDecoder decodeObjectForKey:@"score"] integerValue];
        _level=[aDecoder decodeObjectForKey:@"level"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_pwd forKey:@"pwd"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:@(_age) forKey:@"age"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeObject:_question forKey:@"question"];
    [aCoder encodeObject:_answer forKey:@"answer"];
    [aCoder encodeObject:_photo forKey:@"photo"];
    [aCoder encodeObject:@(_score) forKey:@"score"];
    [aCoder encodeObject:_level forKey:@"level"];
}
@end

@implementation UserInfoLevelModel
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        _name=[aDecoder decodeObjectForKey:@"name"];
        _level=[aDecoder decodeObjectForKey:@"level"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_level forKey:@"level"];
}
@end

@implementation UserInfoRes
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        _data=[aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_data forKey:@"data"];
}
@end







