//
//  ViewTexture.h
//  SKTest
//
//  Created by 孙昕 on 15/11/30.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ViewTexture : NSObject
+(void)registerAtlasName:(NSString*)name Count:(NSInteger)count;
+(void)registerName:(NSString*)name;
+(SKTexture*)textureForName:(NSString*)name;
+(NSArray*)atlasForName:(NSString*)name;
@end
