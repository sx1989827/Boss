//
//  BombPower.m
//  SKTest
//
//  Created by 孙昕 on 15/12/3.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BombPower.h"
#import "ViewTexture.h"
#import "ViewSence.h"
#import "GameUser.h"
#import "GameEnemy.h"
@implementation BombPower
-(instancetype)initWithName:(PowerType)name Value:(NSInteger)value
{
    if(self=[super init])
    {
        self.name=name;
        self.value=value;
        self.node=[SKSpriteNode spriteNodeWithTexture:[ViewTexture textureForName:@"bomb"] size:CGSizeMake(30, 30)];
        GameUser *user=[[ViewSence sharedInstance] valueForKey:@"user"];
        self.node.position=CGPointMake(user.node.position.x+user.node.size.width/2, 30);
        self.node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.node.size];
        self.node.physicsBody.usesPreciseCollisionDetection=YES;
        self.node.physicsBody.affectedByGravity = NO;
        self.node.physicsBody.dynamic=YES;
        self.node.physicsBody.categoryBitMask = BombPowerFlag;
        self.node.physicsBody.collisionBitMask = 0x0;
        self.node.physicsBody.contactTestBitMask = EnemyFlag;
        UIBezierPath* aPath = [UIBezierPath bezierPath];
        aPath.lineCapStyle = kCGLineCapRound;
        aPath.lineJoinStyle = kCGLineCapRound;
        CGPoint p=CGPointMake(user.node.position.x+user.node.size.width/2, 10);
        [aPath moveToPoint:p];
        while(1)
        {
            [aPath addCurveToPoint:CGPointMake(p.x+80,10) controlPoint1:CGPointMake(p.x+30, 30) controlPoint2:CGPointMake(p.x+50 ,-10)];
            if(p.x>=[UIScreen mainScreen].bounds.size.width)
            {
                break;
            }
            else
            {
                p.x+=80;
            }
        }
        SKAction *action=[SKAction followPath:aPath.CGPath speed:80*screenWidthExtra];
        [self.node runAction:action];
        [[ViewSence sharedInstance] addChild:self.node];
        [self.node runAction:[SKAction playSoundFileNamed:@"炸弹.wav" waitForCompletion:NO]];
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
    NSInteger value=self.value-200*(enemy.node.position.x-enemy.node.size.width/2-self.contactRect.origin.x)*1.0/self.contactRect.size.width;
    enemy.money-=value;
    [self effect:enemy Offset:score];
    if(enemy.money<=0)
    {
        [enemy remove];
        [[ViewSence sharedInstance] addScore:score];
    }
}

-(void)effect:(GameEnemy*)enemy Offset:(NSInteger)offset
{
    SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"bomb" ofType:@"sks"]];
    spark.position =CGPointMake(enemy.node.position.x, enemy.node.size.height/2) ;
    [spark runAction:[SKAction sequence:@[[SKAction waitForDuration:1],[SKAction removeFromParent]]]];
    [spark runAction:[SKAction moveByX:-enemy.speed y:0 duration:1]];
    [spark runAction:[SKAction fadeOutWithDuration:1]];
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






