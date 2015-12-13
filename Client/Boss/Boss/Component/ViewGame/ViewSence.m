//
//  ViewSence.m
//  SKTest
//
//  Created by 孙昕 on 15/11/28.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ViewSence.h"
#import "GameEnemy.h"
#import "GameDefine.h"
#import "GameUser.h"
#import "ViewGame.h"
#import "ViewTexture.h"
#import "MyPower.h"
#import "EnemyPower.h"
static __weak ViewSence* singleObj=nil;
@interface ViewSence()<SKPhysicsContactDelegate>
{
    NSInteger powerCount;
    NSMutableArray<GameEnemy*> *arrEnemy;
    NSMutableArray <GameEnemy*>*arrInitEnemy;
    __weak id<ViewGameDelegate> delegateVC;
    NSString *bossName;
    NSTimer *timer;
    GameUser *user;
    __weak ViewGame *game;
    float originEnemyShowInternal;
    float enemyShowInternal;
    NSTimeInterval preTimeInterval;
    NSMutableArray *arrPower;
    GameEnemy *boss;
    NSMutableArray *arrEnemyPower;
}
@end
@implementation ViewSence
-(void)didMoveToView:(SKView *)view
{
    srand((unsigned int)time(0));
    //self.backgroundColor=[UIColor colorWithRed:1.000 green:1.000 blue:0.858 alpha:1.000];
    self.backgroundColor=[UIColor colorWithRed:0.000 green:0.665 blue:1.000 alpha:1.000];
    SKSpriteNode *back=[SKSpriteNode spriteNodeWithTexture:[ViewTexture textureForName:@"backcompany"] size:CGSizeMake(237, 175)];
    back.anchorPoint=CGPointMake(0.5, 0);
    back.position=CGPointMake(self.size.width/2, 0);
    [self addChild:back];
}

-(instancetype)initWithSize:(CGSize)size PowerCount:(NSInteger)powercount Money:(NSInteger)money Time:(NSInteger)time Enemy:(NSDictionary*)enemy LevelName:(NSString*)levelName Delegate:(id<ViewGameDelegate>)delegate ViewGameDeleagte:(id)object
{
	if(self=[super initWithSize:size])
    {
        arrPower=[[NSMutableArray alloc] initWithCapacity:30];
        arrEnemyPower=[[NSMutableArray alloc] initWithCapacity:30];
        self.physicsWorld.gravity=CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        SKPhysicsBody *body = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody = body;
        self.physicsBody.categoryBitMask = EdgeFlag;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = BulletPowerFlag|BombPowerFlag;
        NSInteger count=0;
        for(NSString *key in enemy)
        {
            count+=[enemy[key][@"count"] integerValue];
        }
        originEnemyShowInternal=(time-15)*1.0/(count-1);
        enemyShowInternal=originEnemyShowInternal;
        [self initTexture];
        game=object;
        singleObj=self;
        powerCount=powercount;
        bossName=levelName;
        delegateVC=delegate;
        game.lbMoney.text=[NSString stringWithFormat:@"%ld",money];
        game.lbScore.text=@"0";
        game.lbTime.text=[NSString stringWithFormat:@"%ld",time];
        game.lbPower.text=[NSString stringWithFormat:@"%ld",powerCount];
        game.lbEnemyCount.text=[NSString stringWithFormat:@"%ld",count];
        userMoney=money;
        totleTime=time;
        totleScore=0;
        originTime=time;
        arrEnemy=[[NSMutableArray alloc] initWithCapacity:30];
        arrInitEnemy=[[NSMutableArray alloc] initWithCapacity:30];
        screenWidthExtra=[UIScreen mainScreen].bounds.size.width*1.0/320;
        for(NSString *name in enemy)
        {
            GameEnemy *e=[[GameEnemy alloc] initWithName:name Money:[enemy[name][@"money"] integerValue] Speed:[enemy[name][@"speed"] floatValue]*screenWidthExtra];
            if([name isEqualToString:levelName])
            {
                e.bBoss=YES;
                [arrEnemy addObject:e];
                boss=e;
            }
            else
            {
                NSInteger count=[enemy[name][@"count"] integerValue];
                e.bBoss=NO;
                [arrInitEnemy addObject:e];
                for(int i=0;i<count-1;i++)
                {
                    e=[[GameEnemy alloc] initWithName:name Money:[enemy[name][@"money"] integerValue] Speed:[enemy[name][@"speed"] floatValue]*screenWidthExtra];
                    e.bBoss=NO;
                    [arrInitEnemy addObject:e];
                }
            }
        }
    }
    return self;
}



-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode *node1,*node2;
    if(contact.bodyA.categoryBitMask<contact.bodyB.categoryBitMask)
    {
        node1=(SKSpriteNode*)contact.bodyA.node;
        node2=(SKSpriteNode*)contact.bodyB.node;
    }
    else
    {
        node1=(SKSpriteNode*)contact.bodyB.node;
        node2=(SKSpriteNode*)contact.bodyA.node;
    }
    if(node1.physicsBody.categoryBitMask==UserFlag && node2.physicsBody.categoryBitMask==EnemyFlag)
    {
        GameEnemy *enemy;
        for(GameEnemy *obj in arrEnemy)
        {
            if(obj.node==node2)
            {
                enemy=obj;
                break;
            }
        }
        [enemy hurtUser:user];
        [arrEnemy removeObject:enemy];
        [enemy remove];
    }
    else if(node1.physicsBody.categoryBitMask==EnemyFlag && node2.physicsBody.categoryBitMask==BarrierPowerFlag)
    {
        GameEnemy *enemy;
        for(GameEnemy *obj in arrEnemy)
        {
            if(obj.node==node1)
            {
                enemy=obj;
                break;
            }
        }
        [enemy pause];
    }
    else if(node1.physicsBody.categoryBitMask==EnemyFlag && node2.physicsBody.categoryBitMask==BulletPowerFlag)
    {
        MyPower *power;
        for(MyPower *obj in arrPower)
        {
            if(obj.node==node2)
            {
                power=obj;
                break;
            }
        }
        GameEnemy *enemy;
        for(GameEnemy *obj in arrEnemy)
        {
            if(obj.node==node1)
            {
                enemy=obj;
                break;
            }
        }
        power.contactRect=CGRectMake(contact.contactPoint.x, contact.contactPoint.y, 1, 1);
        [power hurtEnemy:enemy];
        [arrPower removeObject:power];
        [power remove];
    }
    else if(node2.physicsBody.categoryBitMask==EdgeFlag)
    {
        MyPower *power;
        for(MyPower *obj in arrPower)
        {
            if(obj.node==node2)
            {
                power=obj;
                break;
            }
        }
        [arrPower removeObject:power];
        [power remove];
    }
    else if(node1.physicsBody.categoryBitMask==EnemyFlag && node2.physicsBody.categoryBitMask==BombPowerFlag)
    {
        CGRect rect=CGRectMake(contact.contactPoint.x, 0, 60*screenWidthExtra, 100);
        MyPower *power;
        for(MyPower *obj in arrPower)
        {
            if(obj.node==node2)
            {
                power=obj;
                power.contactRect=rect;
                break;
            }
        }
        NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:30];
        [self.physicsWorld enumerateBodiesInRect:rect usingBlock:^(SKPhysicsBody * _Nonnull body, BOOL * _Nonnull stop) {
            for(GameEnemy *obj in arrEnemy)
            {
                if(obj.node.physicsBody==body)
                {
                    [arr addObject:obj];
                }
            }
        }];
        for(GameEnemy *obj in arr)
        {
            [power hurtEnemy:obj];
        }
        [arrPower removeObject:power];
        [power remove];
    }
    else if(node1.physicsBody.categoryBitMask==EnemyFlag && node2.physicsBody.categoryBitMask==LaserPowerFlag)
    {
        MyPower *power;
        for(MyPower *obj in arrPower)
        {
            if(obj.node==node2)
            {
                power=obj;
                break;
            }
        }
        GameEnemy *enemy;
        for(GameEnemy *obj in arrEnemy)
        {
            if(obj.node==node1)
            {
                enemy=obj;
                break;
            }
        }
        power.contactRect=CGRectMake(contact.contactPoint.x, contact.contactPoint.y, 1, 1);
        [power hurtEnemy:enemy];
    }
    else if(node1.physicsBody.categoryBitMask==UserFlag && node2.physicsBody.categoryBitMask==EnemyPowerFlag)
    {
        EnemyPower *power;
        for(EnemyPower *obj in arrEnemyPower)
        {
            if(obj.node==node2)
            {
                power=obj;
                break;
            }
        }
        [power hurtUser:user];
        [arrEnemyPower removeObject:power];
        [power remove];
    }
}

+(instancetype)sharedInstance
{
    return singleObj;
}

-(void)update:(NSTimeInterval)currentTime
{
    if(timer==nil)
    {
        return;
    }
    game.lbEnemyCount.text=[NSString stringWithFormat:@"%ld",arrEnemy.count+arrInitEnemy.count];
    if(totleTime==0 || userMoney<=0 || (powerCount==0 && arrPower.count==0 && arrEnemy.count>0 && arrInitEnemy.count==0))
    {
        if(delegateVC && [delegateVC respondsToSelector:@selector(over:UseTime:Score:)])
        {
            NSInteger score=totleScore+totleScore*(totleTime*1.0/originTime);
            [delegateVC over:NO UseTime:originTime-totleTime Score:score];
            [self stop];
            return;
        }
    }
    else if(arrEnemy.count==0 && arrInitEnemy.count==0)
    {
        if(delegateVC && [delegateVC respondsToSelector:@selector(over:UseTime:Score:)])
        {
            NSInteger score=totleScore+totleScore*(totleTime*1.0/originTime);
            [delegateVC over:YES UseTime:originTime-totleTime Score:score];
            [self stop];
            return;
        }
    }
    if(originTime-totleTime>5)
    {
        if(currentTime-preTimeInterval>=enemyShowInternal)
        {
            [self nextEnemy];
            preTimeInterval=currentTime;
            enemyShowInternal=originEnemyShowInternal+rand()%3-1;
        }
    }
    for(GameEnemy *obj in arrEnemy)
    {
        [obj update];
    }
}

-(void)timerCallback
{
    if(totleTime==0)
    {
        
    }
    else
    {
        totleTime--;
        game.lbTime.text=[NSString stringWithFormat:@"%ld",totleTime];
    }
    game.lbMoney.text=[NSString stringWithFormat:@"%ld",userMoney];
}

-(void)start
{
    timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    user=[[GameUser alloc] init];
//    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[
//                                                     [SKAction waitForDuration:8],
//                                                     [SKAction runBlock:^{
//        GameEnemy *enemy=[self leftMostEnemy];
//        if(enemy)
//        {
//            NSInteger index=rand()%3;
//            NSString *sound=[NSString stringWithFormat:@"%@%ld.wav",enemy.name,index];
//            NSString *path=[[NSBundle mainBundle] pathForResource:sound ofType:nil];
//            if(path)
//            {
//                [enemy.node runAction:[SKAction playSoundFileNamed:sound waitForCompletion:NO]];
//            }
//        }
//    }]
//                                                                       ]]]];
}

-(void)stop
{
    [timer invalidate];
    timer=nil;
    [self removeAllChildren];
    [self setPaused:YES];
}

-(void)nextEnemy
{
    if(arrInitEnemy.count==0)
    {
        return;
    }
    NSInteger index=rand()%arrInitEnemy.count;
    GameEnemy *enemy=arrInitEnemy[index];
    [arrInitEnemy removeObjectAtIndex:index];
    [arrEnemy addObject:enemy];
}

-(void)initTexture
{
    [ViewTexture registerAtlasName:@"码农" Count:5];
    [ViewTexture registerAtlasName:@"美工" Count:5];
    [ViewTexture registerAtlasName:@"测试" Count:5];
    [ViewTexture registerAtlasName:@"码畜" Count:5];
    [ViewTexture registerAtlasName:@"组长" Count:4];
    [ViewTexture registerName:@"user"];
    [ViewTexture registerName:@"bullet"];
    [ViewTexture registerName:@"bomb"];
    [ViewTexture registerName:@"enemybullet"];
    [ViewTexture registerName:@"backcompany"];
    [ViewTexture registerName:@"wall"];
    [ViewTexture registerName:@"laser"];
}

-(void)postPower:(NSString*)power  Value:(NSInteger)value
{
    if(powerCount==0)
    {
        return;
    }
    else
    {
        powerCount--;
        game.lbPower.text=[NSString stringWithFormat:@"%ld",powerCount];
    }
	if([power isEqualToString:@"加时间"])
    {
        [user postPower:Time Value:value];
    }
    else if([power isEqualToString:@"屏障"])
    {
        [user postPower:Barrier Value:value];
    }
    else if([power isEqualToString:@"子弹"])
    {
        [user postPower:Bullet Value:value];
    }
    else if([power isEqualToString:@"炸弹"])
    {
        [user postPower:Bomb Value:value];
    }
    else if([power isEqualToString:@"加工资"])
    {
        [user postPower:Money Value:value];
    }
    else if([power isEqualToString:@"激光"])
    {
        [user postPower:Laser Value:value];
    }
}

-(void)addScore:(NSInteger)score
{
    totleScore+=score;
    game.lbScore.text=[NSString stringWithFormat:@"%ld",totleScore];
}

-(void)hurtUser:(NSInteger)value
{
    if(powerCount==0)
    {
        return;
    }
    else
    {
        powerCount--;
        game.lbPower.text=[NSString stringWithFormat:@"%ld",powerCount];
    }
    BOOL bExistBoss=NO;
    for(GameEnemy* obj in arrEnemy)
    {
        if(obj.bBoss)
        {
            bExistBoss=YES;
            break;
        }
    }
    if(!bExistBoss)
    {
        return;
    }
    EnemyPower *power=[[EnemyPower alloc] initWithValue:value];
    [arrEnemyPower addObject:power];
}

-(GameEnemy*)leftMostEnemy
{
    GameEnemy *leftEnemy=nil;
    for(GameEnemy *enemy in arrEnemy)
    {
        if(leftEnemy==nil)
        {
            leftEnemy=enemy;
        }
        else
        {
            if(enemy.node.position.x<leftEnemy.node.position.x)
            {
                leftEnemy=enemy;
            }
        }
    }
    return leftEnemy;
}
@end






