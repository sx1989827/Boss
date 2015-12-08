//
//  GameUser.m
//  SKTest
//
//  Created by 孙昕 on 15/11/30.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "GameUser.h"
#import "ViewTexture.h"
#import "ViewSence.h"
#import "GameDefine.h"
#import "MyPower.h"
@implementation GameUser


-(instancetype)init
{
	if(self =[super init])
    {
        [self initNode];
    }
    return self;
}

-(void)update
{
	
}

-(void)remove
{
    [_node removeAllActions];
    __block id obj=self;
    [_node runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:0.5],[SKAction removeFromParent]]] completion:^{
        obj=nil;
    }];
}

-(void)postPower:(PowerType)power Value:(NSInteger)value
{
    [MyPower create:power Value:value];
}

-(void)initNode
{
    _node=[SKSpriteNode spriteNodeWithTexture:[ViewTexture textureForName:@"user"]];
    _node.name=@"user";
    _node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_node.size];
    _node.physicsBody.usesPreciseCollisionDetection=YES;
    _node.physicsBody.affectedByGravity=NO;
    _node.physicsBody.dynamic=YES;
    _node.physicsBody.categoryBitMask = UserFlag;
    _node.physicsBody.collisionBitMask = 0x000000000;
    _node.physicsBody.contactTestBitMask = EnemyFlag|EnemyPowerFlag;
    _node.position = CGPointMake(_node.size.width/2, _node.size.height/2);
    //[_node runAction:[SKAction sequence:@[[SKAction repeatActionForever:[SKAction animateWithTextures:[ViewTexture atlasForName:@"user"] timePerFrame:0.2]]]]];
    [[ViewSence sharedInstance] addChild:_node];

}

-(NSInteger)money
{
    return userMoney;
}

-(void)setMoney:(NSInteger)money
{
    userMoney=money;
}
@end



