//
//  TextDrawView.m
//  iOSTest
//
//  Created by 孙昕 on 15/9/4.
//  Copyright (c) 2015年 孙昕. All rights reserved.
//

#import "TextDrawView.h"
#import <CoreText/CoreText.h>
CGFloat viewWidth;
void RunDelegateDeallocCallback( void* refCon ){
}
CGFloat RunDelegateGetAscentCallback( void *refCon ){
    NSDictionary *dic = (__bridge  NSDictionary *)refCon;
    CGFloat width=[dic[@"width"] floatValue];
    if(width==0)
    {
        CGFloat aspect=[dic[@"height"] floatValue];
        CGFloat height=viewWidth*aspect;
        return height;
    }
    else
    {
        CGFloat height=[dic[@"height"] floatValue];
        return height;
    }
}
CGFloat RunDelegateGetDescentCallback(void *refCon){
    return 0;
}
CGFloat RunDelegateGetWidthCallback(void *refCon){
    NSDictionary *dic = (__bridge NSDictionary *)refCon;
    CGFloat width=[dic[@"width"] floatValue];
    if(width==0)
    {
        return viewWidth;
    }
    else
    {
        return width;
    }
}
@interface TextDrawView()
{
    NSMutableAttributedString *attributedString;
    CTFramesetterRef ctFramesetter;
    CGMutablePathRef path;
    CTFrameRef ctFrame ;
    NSMutableDictionary *dicImg;
    CGFloat leftInset;
    CGFloat topInset;
}
@end
@implementation TextDrawView
-(void)setup
{
    dicImg=[[NSMutableDictionary alloc] initWithCapacity:30];
    attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    srand((unsigned int)time(0));
}

-(instancetype)init
{
    if(self=[super init])
    {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if(ctFrame==0)
    {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
    CGContextConcatCTM(context, flipVertical);
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            CFRange range=CTRunGetStringRange(run);
            float offset=CTLineGetOffsetForStringIndex(line, range.location, NULL);
            runRect=CGRectMake(lineOrigin.x +offset , lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            UIColor *col=[attributes objectForKey:NSBackgroundColorAttributeName];
            if(col!=nil)
            {
                CGRect backRect=runRect;
                backRect.origin.x = runRect.origin.x+leftInset ;
                backRect.origin.y = lineOrigin.y+topInset-2;
                CGContextSetFillColorWithColor(context,col.CGColor);
                CGContextFillRect(context , backRect);
            }
            NSString *imageName = [attributes objectForKey:@"imageName"];
            if (imageName)
            {
                NSMutableDictionary *dic=dicImg[imageName];
                CGRect imageDrawRect;
                CGSize size;
                CGFloat width=[dic[@"width"] floatValue];
                if(width==0)
                {
                    CGFloat aspect=[dic[@"height"] floatValue];
                    CGFloat height=viewWidth*aspect;
                    size.width=viewWidth;
                    size.height=height;
                }
                else
                {
                    CGFloat height=[dic[@"height"] floatValue];
                    size.width=width;
                    size.height=height;
                }
                imageDrawRect.size = size;
                imageDrawRect.origin.x = runRect.origin.x+leftInset ;
                imageDrawRect.origin.y = lineOrigin.y+topInset;
                CGRect rect = CGPathGetBoundingBox(path);
                CGFloat y = rect.origin.y + rect.size.height - lineOrigin.y-runAscent;
                [dic setObject:[NSValue valueWithCGRect:CGRectMake(imageDrawRect.origin.x, y, imageDrawRect.size.width, imageDrawRect.size.height)] forKey:@"frame"];
                UIImage *image = [UIImage imageNamed:dic[@"name"]];
                if (image)
                {
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
                else
                {
                    NSString *imageDataPath = [NSHomeDirectory() stringByAppendingPathComponent:[@"Library/Caches/" stringByAppendingString:[[dic[@"name"] stringByReplacingOccurrencesOfString:@"/" withString:@"" ] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imageDataPath]];
                    if(image)
                    {
                        CGContextDrawImage(context, imageDrawRect, image.CGImage);
                    }
                    else
                    {
                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic[@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                            [data writeToFile:imageDataPath atomically:YES];
                            UIImage *image=[UIImage imageWithData:data];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                CGContextDrawImage(context, CGRectMake(imageDrawRect.origin.x*2, imageDrawRect.origin.y*2, imageDrawRect.size.width*2, imageDrawRect.size.height*2), image.CGImage);
                            });
                        });
                    }
                }
            
            }
        }
    }
    CTFrameDraw(ctFrame, context);
}


-(void)addText:(NSString*)text Style:(NSDictionary*)dic ClickBlock:(BOOL (^)(NSMutableAttributedString *str,NSInteger start,NSInteger len))block
{
	NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    if(dic!=nil)
    {
        [str addAttributes:dic range:NSMakeRange(0, text.length)];
    }
    if(block!=nil)
    {
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleThick]  range:NSMakeRange(0, text.length)];
        [str addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor]  range:NSMakeRange(0, text.length)];
        [str addAttribute:@"click" value:block range:NSMakeRange(0, text.length)];
    }
    [attributedString appendAttributedString:str];
}

-(void)addNewLine
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"\r"];
    [attributedString appendAttributedString:str];
}

-(void)addImage:(NSString*)name Width:(CGFloat)width Height:(CGFloat)height ClickBlock:(void (^)())block
{
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = RunDelegateDeallocCallback;
    imageCallbacks.getAscent = RunDelegateGetAscentCallback;
    imageCallbacks.getDescent = RunDelegateGetDescentCallback;
    imageCallbacks.getWidth = RunDelegateGetWidthCallback;
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge_retained void *)(@{@"name":name,@"width":@(width),@"height":@(height)}));
    NSMutableAttributedString *imageAttributedString =[[NSMutableAttributedString alloc] initWithString:@" "];
    [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    NSString *identifer=[self getTimeNow];
    [imageAttributedString addAttribute:@"imageName" value:identifer range:NSMakeRange(0, 1)];
    [attributedString appendAttributedString:imageAttributedString];
    if(block==nil)
    {
        [dicImg setObject:[NSMutableDictionary dictionaryWithDictionary:@{
                                                                          @"name":name,
                                                                          @"width":@(width),
                                                                          @"height":@(height)
                                                                          }] forKey:identifer];
    }
    else
    {
        [dicImg setObject:[NSMutableDictionary dictionaryWithDictionary:@{
                                                                          @"name":name,
                                                                          @"width":@(width),
                                                                          @"height":@(height),
                                                                          @"click":block
                                                                          }] forKey:identifer];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if(path!=0)
    {
        CFRelease(path);
        path=0;
    }
    if(ctFrame!=0)
    {
        CFRelease(ctFrame);
        ctFrame=0;
    }
    if(ctFramesetter!=0)
    {
        CFRelease(ctFramesetter);
        ctFramesetter=0;
    }
    ctFramesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
    path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    viewWidth=CGRectInset(bounds, leftInset, topInset).size.width;
    CGPathAddRect(path , NULL, CGRectInset(bounds, leftInset, topInset));
    ctFrame = CTFramesetterCreateFrame(ctFramesetter,CFRangeMake(0, 0), path, NULL);
    CGFloat height=CTFramesetterSuggestFrameSizeWithConstraints(ctFramesetter, CFRangeMake(0, 0), 0, CGSizeMake(self.bounds.size.width-2*leftInset, CGFLOAT_MAX), 0).height;
    if(self.translatesAutoresizingMaskIntoConstraints==YES)
    {
        CGRect frame=self.frame;
        frame.size.height=height+2*topInset;
        self.frame=frame;
    }
    else
    {
        BOOL bSet=NO;
        for( NSLayoutConstraint *con in self.constraints)
        {
            if(con.firstItem==self && con.firstAttribute==NSLayoutAttributeHeight)
            {
                con.constant=height+2*topInset;
                bSet=YES;
                break;
            }
        }
        if(!bSet)
        {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:height+2*topInset]];
        }
    }
}

-(void)dealloc
{
    if(path!=0)
    {
        CFRelease(path);
    }
    if(ctFrame!=0)
    {
        CFRelease(ctFrame);
    }
    if(ctFramesetter!=0)
    {
        CFRelease(ctFramesetter);
    }
}

-(void)setDrawInset:(CGFloat)left Top:(CGFloat)top
{
    leftInset=left;
    topInset=top;
}

- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString* timeNow = [[NSString alloc] initWithFormat:@"%@%d", date,rand()%1000];
    return timeNow;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(ctFrame==0)
    {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    for(NSString *str in dicImg)
    {
        CGRect rect=[dicImg[str][@"frame"] CGRectValue];
        if(CGRectContainsPoint(rect, location))
        {
            if(dicImg[str][@"click"]!=nil)
            {
                ((void (^)())dicImg[str][@"click"])();
            }
            return;
        }
    }
    location.x-=leftInset;
    location.y-=topInset;
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    NSInteger count=CFArrayGetCount(lines);
    CGPoint origins[count];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), origins);
    CTLineRef line = NULL;
    CGPoint lineOrigin = CGPointZero;
    for (int i= 0; i < CFArrayGetCount(lines); i++)
    {
        CGPoint origin = origins[i];
        CGPathRef path1 = CTFrameGetPath(ctFrame);
        CGRect rect = CGPathGetBoundingBox(path1);
        CGFloat y = rect.origin.y + rect.size.height - origin.y;
        if ((location.y <= y) && (location.x >= origin.x))
        {
            line = CFArrayGetValueAtIndex(lines, i);
            lineOrigin = origin;
            break;
        }
    }
    if(line==0)
    {
        return;
    }
    location.x -= lineOrigin.x;
    CFIndex index = CTLineGetStringIndexForPosition(line, location);
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    for(int i=0;i<CFArrayGetCount(runs);i++)
    {
        CTRunRef run = CFArrayGetValueAtIndex(runs,i);
        NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
        CFRange range=CTRunGetStringRange(run);
        typedef BOOL (^Callback)();
        Callback block=attributes[@"click"];
        if(block!=nil && index>=range.location && index<=range.location+range.length)
        {
            BOOL ret= block(attributedString,range.location,range.length);
            if(ret)
            {
                [self setNeedsLayout];
                [self setNeedsDisplay];
            }
            break;
        }
    }
}

-(void)clear
{
    attributedString=[[NSMutableAttributedString alloc] initWithString:@""];
    [dicImg removeAllObjects];
    if(path!=0)
    {
        CFRelease(path);
        path=0;
    }
    if(ctFrame!=0)
    {
        CFRelease(ctFrame);
        ctFrame=0;
    }
    if(ctFramesetter!=0)
    {
        CFRelease(ctFramesetter);
        ctFramesetter=0;
    }
    [self setNeedsDisplay];
}
@end





