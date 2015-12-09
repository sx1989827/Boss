//
//  BarrierPower.m
//  SKTest
//
//  Created by 孙昕 on 15/12/1.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BarrierPower.h"
#import "ViewSence.h"
#import "GameEnemy.h"
#import "ViewTexture.h"
@implementation BarrierPower
-(instancetype)initWithName:(PowerType)name Value:(NSInteger)value
{
    if(self=[super init])
    {
        self.name=name;
        self.value=value;
        self.node=[SKSpriteNode spriteNodeWithTexture:[ViewTexture textureForName:@"wall"] size:CGSizeMake(5, 150)];
        self.node.name=@"屏障";
        ViewSence *sence=[ViewSence sharedInstance];
        NSArray *arr=[sence valueForKey:@"arrEnemy"];
        NSInteger minleft=[UIScreen mainScreen].bounds.size.width;
        NSArray *arrInit=[sence valueForKey:@"arrInitEnemy"];
        GameEnemy *boss=[sence valueForKey:@"boss"];
        for(GameEnemy *enemy in arr)
        {
                NSInteger left=enemy.node.position.x-enemy.node.size.width/2;
                if(left<minleft)
                {
                    minleft=left;
                }
        }
        if(arr.count==1 && arrInit.count>0 && arr.firstObject==boss)
        {
            self.node.position=CGPointMake([UIScreen mainScreen].bounds.size.width*3.0/4, 75);
        }
        else
        {
            self.node.position=CGPointMake(minleft-5, 75);
        }
        self.node.physicsBody =[ SKPhysicsBody bodyWithRectangleOfSize:self.node.size];
        self.node.physicsBody.usesPreciseCollisionDetection=YES;
        self.node.physicsBody.affectedByGravity = YES;
        self.node.physicsBody.dynamic=YES;
        self.node.physicsBody.restitution=1;
        self.node.physicsBody.categoryBitMask = BarrierPowerFlag;
        self.node.physicsBody.collisionBitMask = 0x0;
        self.node.physicsBody.contactTestBitMask = EnemyFlag;
        SKAction *action=[SKAction sequence:@[[SKAction fadeInWithDuration:0.5],[SKAction waitForDuration:self.value],[SKAction performSelector:@selector(remove) onTarget:self]]];
        [self.node runAction:action];
        [[ViewSence sharedInstance] addChild:self.node];
        [self.node runAction:[SKAction playSoundFileNamed:@"屏障.wav" waitForCompletion:NO]];
        SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"barrier" ofType:@"sks"]];
        spark.position =CGPointMake(self.node.position.x, 0) ;
        [spark runAction:[SKAction sequence:@[[SKAction waitForDuration:3],[SKAction fadeOutWithDuration:0.5],[SKAction removeFromParent]]]];
        [[ViewSence sharedInstance] addChild:spark];
    }
    return self;
}

-(void)remove
{
    [super remove];
    __block id obj=self;
    [self.node runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:0.5],[SKAction removeFromParent]]] completion:^{
        obj=nil;
        NSArray *arr=[[ViewSence sharedInstance] valueForKey:@"arrEnemy"];
        NSArray *arrInit=[[ViewSence sharedInstance] valueForKey:@"arrInitEnemy"];
        for(GameEnemy *obj in arr)
        {
            if(!obj.bBoss)
            {
                [obj resume];
            }
            else if(obj.bBoss && arr.count==1 && arrInit.count==0)
            {
                [obj resume];
            }
        }
    }];
}
@end


