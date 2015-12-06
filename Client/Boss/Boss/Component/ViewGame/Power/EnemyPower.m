//
//  EnemyPower.m
//  SKTest
//
//  Created by 孙昕 on 15/12/3.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "EnemyPower.h"
#import "ViewTexture.h"
#import "ViewSence.h"
#import "GameUser.h"
#import "GameEnemy.h"
@implementation EnemyPower
-(instancetype)initWithValue:(NSInteger)value
{
    if(self=[super init])
    {
        self.value=value;
        self.node=[SKSpriteNode spriteNodeWithTexture:[ViewTexture textureForName:@"enemybullet"] size:CGSizeMake(20, 20)];
        GameEnemy *boss=[[ViewSence sharedInstance] valueForKey:@"boss"];
        self.node.position=CGPointMake(boss.node.position.x-boss.node.size.width/2, 30);
        self.node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.node.size];
        self.node.physicsBody.usesPreciseCollisionDetection=YES;
        self.node.physicsBody.affectedByGravity = NO;
        self.node.physicsBody.dynamic=YES;
        self.node.physicsBody.categoryBitMask = EnemyPowerFlag;
        self.node.physicsBody.collisionBitMask = 0x0;
        self.node.physicsBody.contactTestBitMask = UserFlag;
        SKAction *action=[SKAction repeatActionForever:[SKAction moveByX:-80*screenWidthExtra y:0 duration:1]];
        [self.node runAction:action];
        [self.node runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:-10.0/180*31.4 duration:0.1]]];
        [[ViewSence sharedInstance] addChild:self.node];
    }
    return self;
}

-(void)remove
{
    [self.node removeAllActions];
    NSMutableArray *arr=[[ViewSence sharedInstance] valueForKey:@"arrEnemyPower"];
    [arr removeObject:self];
    __block id obj=self;
    [self.node runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:0.5],[SKAction removeFromParent]]] completion:^{
        obj=nil;
    }];
}

-(void)hurtUser:(GameUser*)user
{
    user.money-=self.value;
    [self effect];
}


-(void)effect
{
    GameUser *user=[[ViewSence sharedInstance] valueForKey:@"user"];
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = [NSString stringWithFormat:@"-%ld",self.value];
    myLabel.fontSize = 15;
    myLabel.position = CGPointMake(user.node.position.x, user.node.size.height+5);
    [myLabel runAction:[SKAction moveByX:0 y:60 duration:2]];
    [myLabel runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:2],[SKAction removeFromParent]]]];
    [[ViewSence sharedInstance] addChild:myLabel];
}
@end







