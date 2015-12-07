//
//  BulletPower.m
//  SKTest
//
//  Created by 孙昕 on 15/12/1.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BulletPower.h"
#import "ViewTexture.h"
#import "ViewSence.h"
#import "GameUser.h"
#import "GameEnemy.h"
@implementation BulletPower
-(instancetype)initWithName:(PowerType)name Value:(NSInteger)value
{
    if(self=[super init])
    {
        self.name=name;
        self.value=value;
        self.node=[SKSpriteNode spriteNodeWithTexture:[ViewTexture textureForName:@"bullet"] size:CGSizeMake(20, 20)];
        GameUser *user=[[ViewSence sharedInstance] valueForKey:@"user"];
        self.node.position=CGPointMake(user.node.position.x+user.node.size.width/2, 30);
        self.node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.node.size];
        self.node.physicsBody.usesPreciseCollisionDetection=YES;
        self.node.physicsBody.affectedByGravity = NO;
        self.node.physicsBody.dynamic=YES;
        self.node.physicsBody.categoryBitMask = BulletPowerFlag;
        self.node.physicsBody.collisionBitMask = 0x0;
        self.node.physicsBody.contactTestBitMask = EnemyFlag;
        SKAction *action=[SKAction repeatActionForever:[SKAction moveByX:80*screenWidthExtra y:0 duration:1]];
        [self.node runAction:action];
        [self.node runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:10.0/180*31.4 duration:0.1]]];
        [[ViewSence sharedInstance] addChild:self.node];
        [self.node runAction:[SKAction playSoundFileNamed:@"子弹.wav" waitForCompletion:NO]];
    }
    return self;
}

-(void)remove
{
    [super remove];
    __block id obj=self;
    [self.node runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:0.5],[SKAction removeFromParent]]] completion:^{
        obj=nil;
    }];
}

-(void)hurtEnemy:(GameEnemy*)enemy
{
    NSInteger score=enemy.money;
    enemy.money-=self.value;
    [self effect:enemy Offset:score];
    if(enemy.money<=0)
    {
        [enemy remove];
        [[ViewSence sharedInstance] addScore:score];
    }
}

-(void)effect:(GameEnemy*)enemy Offset:(NSInteger)offset
{
    SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"bullet" ofType:@"sks"]];
    spark.position =self.contactRect.origin ;
    [spark runAction:[SKAction sequence:@[[SKAction waitForDuration:0.5],[SKAction removeFromParent]]]];
    [spark runAction:[SKAction moveByX:-enemy.speed y:0 duration:1]];
    [spark runAction:[SKAction fadeOutWithDuration:0.5]];
    [[ViewSence sharedInstance] addChild:spark];
    if(enemy.money<=0)
    {
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = [NSString stringWithFormat:@"+%ld",offset];
        myLabel.fontSize = 15;
        myLabel.fontColor=[UIColor redColor];
        myLabel.position = CGPointMake(self.contactRect.origin.x, enemy.node.size.height+5);
        [myLabel runAction:[SKAction moveByX:0 y:60 duration:2]];
        [myLabel runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:2],[SKAction removeFromParent]]]];
        [[ViewSence sharedInstance] addChild:myLabel];
    }
}
@end








