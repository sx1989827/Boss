//
//  IntroView.m
//  Boss
//
//  Created by 孙昕 on 15/12/10.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "IntroView.h"
#import "Header.h"
typedef void (^BLOCK)();

struct IntroLine
{
    CGPoint p1,p2;
    double a,b,c;
};

void GetLinePara(struct IntroLine *l)
{
    l->a=l->p1.y-l->p2.y;
    l->b=l->p2.x-l->p1.x;
    l->c=l->p1.x*l->p2.y-l->p2.x*l->p1.y;
}

CGPoint GetCrossPoint(struct IntroLine *l1,struct IntroLine *l2)
{
    GetLinePara(l1);
    GetLinePara(l2);
    double D=l1->a*l2->b-l2->a*l1->b;
    CGPoint p;
    p.x=(l1->b*l2->c-l2->b*l1->c)/D;
    p.y=(l1->c*l2->a-l2->c*l1->a)/D;
    return p;
}

BOOL isPointOnSegment(CGPoint p,CGPoint p1,CGPoint p2)
{

//    if (( p1.x -p.x )*( p2.y-p.y) -( p2.x -p.x )*( p1.y-p.y)!=0)
//    {
//        return false;
//    }
    if ((p.x - p1.x>0.000001 && p.x - p2.x>0.000001) || (p.x - p1.x<-0.000001 && p.x - p2.x<-0.000001))
    {
        return false;
    }
    if ((p.y - p1.y>0.000001 && p.y - p2.y>0.000001) || (p.y- p1.y<-0.000001 && p.y - p2.y<-0.000001))
    {
        return false;
    }
    return true;
}

CGFloat pointLen(CGPoint center1,CGPoint center2,CGRect rect)
{
    NSArray *arr=@[
                   [NSValue valueWithCGPoint:CGPointMake(rect.origin.x, rect.origin.y)],
                   [NSValue valueWithCGPoint:CGPointMake(rect.origin.x+rect.size.width-1, rect.origin.y)],
                   [NSValue valueWithCGPoint:CGPointMake(rect.origin.x+rect.size.width-1, rect.origin.y+rect.size.height-1)],
                   [NSValue valueWithCGPoint:CGPointMake(rect.origin.x, rect.origin.y+rect.size.height-1)],
                   [NSValue valueWithCGPoint:CGPointMake(rect.origin.x, rect.origin.y)]
                   ];
    struct IntroLine line;
    line.p1=center1;
    line.p2=center2;
    for(int i=0;i<arr.count-1;i++)
    {
        struct IntroLine l;
        l.p1=[arr[i] CGPointValue];
        l.p2=[arr[i+1] CGPointValue];
        CGPoint p=GetCrossPoint(&line, &l);
        if(isPointOnSegment(p,center1,center2) && isPointOnSegment(p,l.p1,l.p2))
        {
            return sqrt(pow(p.x-center1.x, 2)+pow(p.y-center1.y, 2));
        }
    }
    return 0;
}
@interface IntroModel:NSObject
@property (strong,nonatomic) NSString *title;
@property (assign,nonatomic) CGRect rectTitle;
@property (assign,nonatomic) CGRect rectView;
@property (strong,nonatomic) UIImage* img;
@end
@implementation IntroModel


@end
@interface IntroView()
@property (strong,nonatomic) BLOCK block;
@property (strong,nonatomic) CAShapeLayer *layerLine;
@property (strong,nonatomic) NSMutableArray<IntroModel*> *arrModel;
@property (strong,nonatomic) UILabel *lbTitle;
@property (strong,nonatomic) UIImageView *imgView;
@property (assign,nonatomic) NSInteger index;
@end
@implementation IntroView

+(void)showTitle:(NSArray*)arr Block:(void (^)())block
{
    IntroView *viewIntro=[[IntroView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    viewIntro.block=block;
    viewIntro.layer.zPosition=FLT_MAX;
    [[UIApplication sharedApplication].keyWindow addSubview:viewIntro];
    viewIntro.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    viewIntro.arrModel=[[NSMutableArray alloc] initWithCapacity:30];
    for(NSDictionary *dic in arr)
    {
        IntroModel *obj=[[IntroModel alloc] init];
        NSString *title=dic[@"title"];
        CGRect rect=[dic[@"rect"] CGRectValue];
        UIView *view=dic[@"view"];
        if(view==nil)
        {
            continue;
        }
        obj.title=title;
        obj.rectTitle=rect;
        obj.img=[view imageCache];
        obj.rectView=[((UIView*)[UIApplication sharedApplication].keyWindow) convertRect:view.bounds fromView:view];
        [viewIntro.arrModel addObject:obj];
    }
    if(viewIntro.arrModel.count==0)
    {
        [viewIntro removeFromSuperview];
        return;
    }
    IntroModel *model=viewIntro.arrModel[0];
    viewIntro.imgView=[[UIImageView alloc] initWithFrame:model.rectView];
    viewIntro.imgView.backgroundColor=[UIColor clearColor];
    viewIntro.imgView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:viewIntro action:@selector(tap:)];
    [viewIntro.imgView addGestureRecognizer:tap];
    viewIntro.imgView.image=model.img;
    viewIntro.lbTitle=[[UILabel alloc] initWithFrame:model.rectTitle];
    viewIntro.lbTitle.font=[UIFont systemFontOfSize:18];
    viewIntro.lbTitle.textColor=[UIColor whiteColor];
    viewIntro.lbTitle.textAlignment=NSTextAlignmentCenter;
    viewIntro.lbTitle.text=model.title;
    viewIntro.lbTitle.numberOfLines=0;
    viewIntro.lbTitle.layer.masksToBounds=YES;
    viewIntro.lbTitle.layer.cornerRadius=10;
    viewIntro.lbTitle.backgroundColor=[UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000];
    tap=[[UITapGestureRecognizer alloc] initWithTarget:viewIntro action:@selector(tap:)];
    viewIntro.lbTitle.userInteractionEnabled=YES;
    [viewIntro.lbTitle addGestureRecognizer:tap];
    viewIntro.layerLine = [CAShapeLayer layer];
    viewIntro.layerLine.zPosition=FLT_MIN;
    viewIntro.layerLine.fillColor = [UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000].CGColor;
    viewIntro.layerLine.lineWidth =  5.0f;
    viewIntro.layerLine.lineCap = kCALineCapRound;
    viewIntro.layerLine.lineJoin = kCALineJoinRound;
    viewIntro.layerLine.strokeColor = [UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000].CGColor;
    [viewIntro.layer addSublayer:viewIntro.layerLine];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:viewIntro.lbTitle.center];
    [path addLineToPoint:viewIntro.imgView.center];
    viewIntro.layerLine.path=path.CGPath;
    CGFloat len1=pointLen(viewIntro.lbTitle.center ,viewIntro.imgView.center,viewIntro.lbTitle.frame)+0.01;
    CGFloat len2=pointLen(viewIntro.imgView.center,viewIntro.lbTitle.center  ,viewIntro.imgView.frame)-0.01;
    CGFloat len=sqrt(pow(viewIntro.lbTitle.center.x-viewIntro.imgView.center.x,2) +pow(viewIntro.lbTitle.center.y-viewIntro.imgView.center.y,2));
    viewIntro.layerLine.strokeStart=len1/len;
    viewIntro.layerLine.strokeEnd=(len-len2)/len;
    [viewIntro addSubview:viewIntro.lbTitle];
    [viewIntro addSubview:viewIntro.imgView];
}

-(void)tap:(UIGestureRecognizer*)ges
{
    _index++;
    if(_index==_arrModel.count)
    {
        [self click];
        return;
    }
    IntroModel *model=_arrModel[_index];
    [UIView animateWithDuration:0.5 animations:^{
        _imgView.frame=model.rectView;
        _imgView.image=model.img;
        _lbTitle.text=model.title;
        _lbTitle.frame=model.rectTitle;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:_lbTitle.center];
        [path addLineToPoint:_imgView.center];
        _layerLine.path=path.CGPath;
        CGFloat len1=pointLen(_lbTitle.center ,_imgView.center,_lbTitle.frame)+0.01;
        CGFloat len2=pointLen(_imgView.center,_lbTitle.center  ,_imgView.frame)-0.01;
        CGFloat len=sqrt(pow(_lbTitle.center.x-_imgView.center.x,2) +pow(_lbTitle.center.y-_imgView.center.y,2));
        _layerLine.strokeStart=len1/len;
        _layerLine.strokeEnd=(len-len2)/len;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)click
{
    if(_block)
    {
        _block();
    }
    _block=nil;
    [self removeFromSuperview];
}


@end











