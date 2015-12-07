//
//  GameEnemy.m
//  SKTest
//
//  Created by 孙昕 on 15/11/30.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "GameEnemy.h"
#import "ViewTexture.h"
#import "GameDefine.h"
#import "ViewSence.h"
#import "GameUser.h"
@interface GameEnemy()
{
    BOOL bBossMove;
}
@end
@implementation GameEnemy


-(instancetype)initWithName:(NSString*)name Money:(NSInteger)money Speed:(float)speed
{
	if(self=[super init])
    {
        srand((unsigned int)time(0));
        _name=name;
        _money=money;
        _speed=speed;
        
    }
    return  self;
}

-(void)update
{
	if(_node==nil)
    {
        [self initNode];
    }
    else
    {
        if(_bBoss && !bBossMove)
        {
            NSArray *arr=[[ViewSence sharedInstance] valueForKey:@"arrEnemy"];
            NSArray *arrInit=[[ViewSence sharedInstance] valueForKey:@"arrInitEnemy"];
            if(arr.count==1 && arrInit.count==0 && [arr lastObject]==self)
            {
                if([_node actionForKey:@"move"]==nil)
                {
                    bBossMove=YES;
                    [_node runAction:[SKAction repeatActionForever:[SKAction moveByX:-_speed y:0 duration:1]] withKey:@"move" ];
                }
            }
        }
    }
}

-(void)hurtUser:(GameUser*)user
{
	user.money-=self.money;
    [self effect];
}

-(void)initNode
{
    _node=[SKSpriteNode spriteNodeWithTexture:[[ViewTexture atlasForName:_name] firstObject]];
    _node.name=_name;
    _node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_node.size];
    _node.physicsBody.usesPreciseCollisionDetection=YES;
    _node.physicsBody.affectedByGravity = NO;
    _node.physicsBody.dynamic=YES;
    _node.physicsBody.friction = 1;
    _node.physicsBody.categoryBitMask = EnemyFlag;
    _node.physicsBody.collisionBitMask = 0x0;
    _node.physicsBody.contactTestBitMask = BarrierPowerFlag|BulletPowerFlag|BombPowerFlag|LaserPowerFlag|UserFlag;
    if(_bBoss)
    {
        _node.position = CGPointMake([UIScreen mainScreen].bounds.size.width-_node.size.width/2, _node.size.height/2);
    }
    else
    {
        GameEnemy *boss=[[ViewSence sharedInstance] valueForKey:@"boss"];
        _node.position = CGPointMake([UIScreen mainScreen].bounds.size.width-_node.size.width/2-boss.node.size.width, _node.size.height/2);
    }
    SKAction *action=[SKAction repeatActionForever:[SKAction animateWithTextures:[ViewTexture atlasForName:_name] timePerFrame:0.2]];
    [_node runAction:action];
    if(!_bBoss)
    {
        [_node runAction:[SKAction repeatActionForever:[SKAction moveByX:-_speed y:0 duration:1]] withKey:@"move"];
    }
    [[ViewSence sharedInstance] addChild:_node];
}

-(void)remove
{
    [_node removeAllActions];
    _node.physicsBody.collisionBitMask=0;
    _node.physicsBody.contactTestBitMask=0;
    _node.physicsBody.categoryBitMask=0;
    if([self.name isEqualToString:@"美工"] || [self.name isEqualToString:@"hr"])
    {
        [self.node runAction:[SKAction playSoundFileNamed:@"女死亡.wav" waitForCompletion:NO]];
    }
    else
    {
        [self.node runAction:[SKAction playSoundFileNamed:@"男死亡.wav" waitForCompletion:NO]];
    }
    NSMutableArray *arr=[[ViewSence sharedInstance] valueForKey:@"arrEnemy"];
    [arr removeObject:self];
    __block id obj=self;
    [_node runAction:[SKAction sequence:@[[SKAction moveToY:_node.size.width/2 duration:0.3],[SKAction rotateToAngle:M_PI_2 duration:0.5],[SKAction fadeOutWithDuration:0.5],[SKAction removeFromParent]]] completion:^{
        obj=nil;
    }];
}

-(void)effect
{
    GameUser *user=[[ViewSence sharedInstance] valueForKey:@"user"];
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = [NSString stringWithFormat:@"-%ld",self.money];
    myLabel.fontSize = 15;
    myLabel.position = CGPointMake(user.node.position.x, user.node.size.height+5);
    [myLabel runAction:[SKAction moveByX:0 y:60 duration:2]];
    [myLabel runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:2],[SKAction removeFromParent]]]];
    [[ViewSence sharedInstance] addChild:myLabel];
}

-(void)pause
{
    if([_node actionForKey:@"move"]!=nil)
    {
        [_node removeActionForKey:@"move"];
    }
}

-(void)resume
{
    if([_node actionForKey:@"move"]==nil)
    {
        [_node runAction:[SKAction repeatActionForever:[SKAction moveByX:-_speed+rand()%(NSInteger)(_speed/5)-(NSInteger)(_speed/5) y:0 duration:1]] withKey:@"move"];
    }
}
@end






