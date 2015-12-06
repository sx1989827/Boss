//
//  ViewTexture.m
//  SKTest
//
//  Created by 孙昕 on 15/11/30.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ViewTexture.h"
static NSMutableDictionary *dicTexture;
@implementation ViewTexture
+(void)registerAtlasName:(NSString*)name Count:(NSInteger)count
{
	if(dicTexture==nil)
    {
        dicTexture=[[NSMutableDictionary alloc] initWithCapacity:30];
    }
    NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:30];
    for(int i=1;i<=count;i++)
    {
        SKTexture *tex=[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@%d",name,i]];
        [arr addObject:tex];
    }
    [dicTexture setObject:arr forKey:name];
}

+(void)registerName:(NSString*)name
{
    if(dicTexture==nil)
    {
        dicTexture=[[NSMutableDictionary alloc] initWithCapacity:30];
    }
    [dicTexture setObject:[SKTexture textureWithImageNamed:name] forKey:name];
}

+(SKTexture*)textureForName:(NSString*)name
{
    return [dicTexture objectForKey:name];
}

+(NSArray*)atlasForName:(NSString*)name
{
	return [dicTexture objectForKey:name];
}
@end





