//
//  LevelView.m
//  Boss
//
//  Created by 孙昕 on 15/11/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "LevelView.h"
@interface Node:NSObject
@property (strong,nonatomic) NSString* title;
@property (assign,nonatomic) CGPoint point;
@end
@implementation Node
@end
@interface LevelView()
{
    NSMutableArray *arrNodes;
    NSMutableArray *arrPointX;
    NSInteger indexLast;
    CGFloat y;
    CAShapeLayer *layer;
    CGFloat radius;
    UIButton *btnUser;
    NSInteger iMaxCount;
}
@end
@implementation LevelView
-(instancetype)initWithNodes:(NSArray*)nodes UserIndex:(NSInteger)indexUser MaxCount:(NSInteger)maxCount
{
    if(self=[super init])
    {
        srand((unsigned int)time(0));
        iMaxCount=maxCount;
        radius=([UIScreen mainScreen].bounds.size.height-64)/10;
        arrNodes=[[NSMutableArray alloc] initWithCapacity:30];
        arrPointX=[[NSMutableArray alloc] initWithCapacity:30];
        NSInteger width=[UIScreen mainScreen].bounds.size.width;
        [arrPointX addObject:@(width/4)];
        [arrPointX addObject:@(width/2)];
        [arrPointX addObject:@(width*3/4)];
        indexLast=-1;
        y=[UIScreen mainScreen].bounds.size.height-64-radius/2;
        for(NSString *str in nodes)
        {
            Node *node=[[Node alloc] init];
            node.title=str;
            while (1) {
                NSInteger index=rand()%3;
                if(index!=indexLast)
                {
                    indexLast=index;
                    break;
                }
            }
            node.point=CGPointMake([arrPointX[indexLast] integerValue], y);
            y-=radius;
            [arrNodes addObject:node];
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
            btn.tag=arrNodes.count-1;
            btn.frame=CGRectMake(node.point.x-(radius-4)/2, node.point.y-(radius-4)/2, (radius-4), (radius-4));
            btn.layer.zPosition=FLT_MAX;
            [btn setTitle:str forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if(btn.tag==indexUser)
            {
                btnUser=[UIButton buttonWithType:UIButtonTypeSystem];
                btnUser.frame=CGRectMake(node.point.x-(radius-4)/2, node.point.y-(radius-4)/2, (radius-4), (radius-4));
                btnUser.layer.masksToBounds=YES;
                btnUser.layer.cornerRadius=btnUser.bounds.size.width/2;
                btnUser.layer.zPosition=FLT_MAX;
                [btnUser setBackgroundColor:[UIColor greenColor]];
                [self addSubview:btnUser];
            }
        }
        layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000].CGColor;
        layer.lineWidth =  2.0f;
        layer.lineCap = kCALineCapRound;
        layer.lineJoin = kCALineJoinRound;
        layer.strokeColor = [UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000].CGColor;
        [self.layer addSublayer:layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:((Node*)arrNodes[0]).point radius:(radius-4)/2 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        for(int i=1;i<arrNodes.count;i++)
        {
            [path moveToPoint:((Node*)arrNodes[i-1]).point];
            [path addLineToPoint:((Node*)arrNodes[i]).point];
            [path addArcWithCenter:((Node*)arrNodes[i]).point radius:(radius-4)/2 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        }
        layer.path=path.CGPath;
        layer.strokeStart=0;
        layer.strokeEnd=1;
    }
    return self;
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    layer.fillColor = [UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000].CGColor;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.tag=arrNodes.count-1;
    btn.frame=CGRectMake(((Node*)arrNodes.lastObject).point.x-(radius-4)/2, ((Node*)arrNodes.lastObject).point.y-(radius-4)/2, (radius-4), (radius-4));
    btn.layer.zPosition=FLT_MAX;
    [btn setTitle:[anim valueForKey:@"text"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btnUser.center=((Node*)arrNodes[arrNodes.count-2]).point;
        [btnUser.superview bringSubviewToFront:btnUser];
    } completion:^(BOOL finished) {
        
    }];

}

-(void)click:(UIButton*)btn
{
    if(_delegateNode && [_delegateNode respondsToSelector:@selector(LevelViewClick:Text:)])
    {
        [_delegateNode LevelViewClick:btn.tag Text:[btn titleForState:UIControlStateNormal]];
    }
}

-(BOOL)updateUser:(NSString*)nextText
{
    if(arrNodes.count==iMaxCount)
    {
        return NO;
    }
    while (1) {
        NSInteger index=rand()%3;
        if(index!=indexLast)
        {
            indexLast=index;
            break;
        }
    }
    Node *node=[[Node alloc] init];
    node.title=nextText;
    node.point=CGPointMake([arrPointX[indexLast] integerValue], y);
    y-=radius;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:((Node*)arrNodes.lastObject).point];
    [path addLineToPoint:node.point];
    [path addArcWithCenter:node.point radius:(radius-4)/2 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    [arrNodes addObject:node];
    layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth =  2.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeColor = [UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000].CGColor;
    [self.layer addSublayer:layer];
    layer.path=path.CGPath;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.duration = 2.0;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.delegate=self;
    [animation setValue:nextText forKey:@"text"];
    [layer addAnimation:animation forKey:@"node"];
    return YES;
}
@end








