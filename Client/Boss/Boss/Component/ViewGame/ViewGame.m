//
//  ViewTest.m
//  SKTest
//
//  Created by 孙昕 on 15/11/28.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ViewGame.h"
#import "ViewSence.h"
#import "Header.h"
@interface ViewGame()
{
    ViewSence *sence;
}
@end
@implementation ViewGame
-(instancetype)initWithPowerCount:(NSInteger)count Money:(NSInteger)money Time:(NSInteger)usetime Enemy:(NSDictionary*)enemy LevelName:(NSString*)levelName Delegate:(id<ViewGameDelegate>)delegate
{
    self=(ViewGame*)[[[NSBundle mainBundle] loadNibNamed:@"ViewGame" owner:nil options:nil] lastObject];
    if(self)
    {
        srand((unsigned int)time(0));
        self.translatesAutoresizingMaskIntoConstraints=YES;
        self.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin;
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
        self.showsFPS = YES; 
        self.showsDrawCount = YES;
        self.showsNodeCount = YES;
        sence=[[ViewSence alloc] initWithSize:self.bounds.size PowerCount:count Money:money Time:usetime Enemy:enemy LevelName:levelName Delegate:delegate ViewGameDeleagte:self];
        [self presentScene:sence];
    }
    return self;
}

-(void)start
{
    [sence start];
    
}

-(void)stop
{
    [sence stop];
}

-(void)postPower:(NSString*)power  Value:(NSInteger)value
{
    [sence postPower:power Value:value];
}

-(void)hurtUser:(NSInteger)value
{
    [sence hurtUser:value];
}

-(void)pause
{
    [sence setPaused:YES];
    NSTimer *timer=[sence valueForKey:@"timer"];
    [timer pause];
}

-(void)resume
{
    [sence setPaused:NO];
    NSTimer *timer=[sence valueForKey:@"timer"];
    [timer resume];
}

@end







