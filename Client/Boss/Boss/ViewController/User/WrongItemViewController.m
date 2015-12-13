//
//  WrongItemViewController.m
//  Boss
//
//  Created by libruce on 15/12/10.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "WrongItemViewController.h"
#import "Util.h"
#import "Header.h"
#import "WrongReq.h"
#import "CustomContentView.h"
@interface WrongItemViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)NSArray *itemArray;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong) CustomContentView*contentView;
@property(nonatomic)CGFloat  contentOffsetX;
@property(nonatomic)CGFloat  startOffsetX;
@property(nonatomic)CGFloat  endOffsetX;
@end

@implementation WrongItemViewController
- (void)viewDidLoad {
        [super viewDidLoad];
        self.title = @"错题";
        self.automaticallyAdjustsScrollViewInsets =NO;
        NSString *str ;
    for (int i=0; i<self.item.count; i++) {
        NSString *string = self.item[i];
        if (i==0) {
            str = string;
        }else
        {
            str  =[str stringByAppendingString:[NSString stringWithFormat:@",%@",string]];
        }
    }
    [WrongReq do:^(id req) {
        WrongReq*obj =req;
        obj.item =str;
    } Res:^(id res) {
        WrongRes*obj =res;
        self.itemArray = obj.data;
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*self.itemArray.count, self.view.frame.size.height-64);
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator =NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO;
        [self setNavgitionLabel];
        [self createView];
        [self removeHud];
    } ShowHud:NO];
}
-(void)setNavgitionLabel
{
        _countLabel = [[UILabel alloc]init];
        _countLabel.frame = CGRectMake(0, 0, 40, 20);
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.text = [NSString stringWithFormat:@"1/ %lu",(unsigned long)self.itemArray.count];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:_countLabel];
        self.navigationItem.rightBarButtonItem = right;
}
-(void)createView
{
    if(self.itemArray.count>=3)
    {
        for (int i =0; i<3; i++) {
            [self setContentViewContent:i];
        }
    }else if (self.itemArray.count==2|self.itemArray.count==1)
    {
        for (int i =0; i<self.itemArray.count; i++) {
           
            [self setContentViewContent:i];
        }
    }
}
-(void)setContentViewContent:(int)i
{
    _contentView = [[CustomContentView alloc]init];
    _contentView.tag =i+1;
     _contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _contentView.frame = CGRectMake((self.view.frame.size.width*i), 0, self.view.frame.size.width, self.view.frame.size.height-64);
    _contentView.contentTextView.frame =CGRectMake(10, 10, _contentView.bounds.size.width-20,  _contentView.bounds.size.height-20);
    WrongModel*model = self.itemArray[0];
    CGSize viewHeight = [Util getContentSize:model.content withCGSize:CGSizeMake(_contentView.frame.size.width, MAXFLOAT) withSystemFontOfSize:17];
    _contentView.contentTextView.frame =CGRectMake(10, 10, _contentView.bounds.size.width-20,  viewHeight.height+50);
    NSMutableAttributedString *mutableString = [self stringWithIndex:0];
    _contentView.contentTextView.attributedText = mutableString;
    [self.scrollView addSubview:_contentView];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        NSInteger a=scrollView.contentOffset.x/self.view.frame.size.width;
        self.countLabel.text = [NSString stringWithFormat:@"%ld/ %lu",(long)(a+1),(unsigned long)self.itemArray.count];
         _contentOffsetX = scrollView.contentOffset.x;
    int contentOffsetX = _contentOffsetX/self.view.frame.size.width;
    BOOL isMoreThanThree = scrollView.contentSize.width/self.view.bounds.size.width>3?YES:NO;
    if (_startOffsetX<_endOffsetX) {
        if (self.scrollView.contentSize.width-_contentOffsetX<=self.view.frame.size.width) {
            return;
        }
        if (isMoreThanThree) {
            if (contentOffsetX%3==2) {
               [self addViewWith:contentOffsetX+1 with:1];
            }else if(contentOffsetX%3==0)
            {
                [self addViewWith:contentOffsetX+1 with:2];
            }
            else if(contentOffsetX%3==1)
            {
                [self addViewWith:contentOffsetX+1 with:3];
            }
        }
    }else if(_startOffsetX>_endOffsetX)
    {
        if (isMoreThanThree) {
            if (contentOffsetX%3==2) {
                 [self addViewWith:contentOffsetX-1 with:2];
            }else if(contentOffsetX%3==0)
            {
                [self addViewWith:contentOffsetX-1 with:3];
            }
            else if(contentOffsetX%3==1)
            {
                [self addViewWith:contentOffsetX-1 with:1];
            }
        }
    }
}
-(void)addViewWith:(int)contentOffset with:(int)tag
{
    if (contentOffset<0) {
        return;
    }
     CustomContentView*view =(CustomContentView*)[self.scrollView viewWithTag:tag];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    view.frame = CGRectMake((self.view.frame.size.width*contentOffset), 0, self.view.frame.size.width, self.view.frame.size.height-64);
    WrongModel*model = self.itemArray[contentOffset];
    CGSize viewHeight = [Util getContentSize:model.content withCGSize:CGSizeMake(view.frame.size.width, MAXFLOAT) withSystemFontOfSize:17];
    view.contentTextView.frame =CGRectMake(10, 10, view.bounds.size.width-20,  viewHeight.height+30);
    NSMutableAttributedString *mutableString = [self stringWithIndex:contentOffset];
    view.contentTextView.attributedText = mutableString;
}
-(NSMutableAttributedString*)stringWithIndex:(int)index
{
    NSMutableAttributedString *mutableString;
    WrongModel*model = self.itemArray[index];
    NSString*answer=@"";
    NSString *modelContent=@"";
    int count=1;
    NSMutableArray *rangeArray = [[NSMutableArray alloc]initWithCapacity:30];
    NSMutableArray *answerLengthArray = [[NSMutableArray alloc]initWithCapacity:30];
    for (int i =0; i<model.answer.count; i++) {
        NSDictionary*dic = model.answer[i];
        NSRange range;
        answer = [NSString stringWithFormat:@"%@",dic[@"ok"]];
        if ([model.content containsString:@"(?)"]) {
            if (count==1) {
                range = [model.content rangeOfString:@"(?)"];
                modelContent = [model.content stringByReplacingCharactersInRange:range withString:answer];
            }else
            {
                range = [modelContent rangeOfString:@"(?)"];
                modelContent = [modelContent stringByReplacingCharactersInRange:range withString:answer];
            }
            count++;
        }
        [rangeArray addObject:[NSValue valueWithRange:range]];
        [answerLengthArray addObject:[NSNumber numberWithInteger:answer.length]];
        if (count==model.answer.count+1) {
            mutableString = [[NSMutableAttributedString alloc]initWithString:modelContent];
            for (int j=0;j<rangeArray.count;j++) {
                NSValue *value =rangeArray[j];
                NSRange range =   [value rangeValue];
                NSNumber*lengthNumber = answerLengthArray[j];
                NSInteger answerLength = [lengthNumber integerValue];
                [mutableString addAttribute:NSForegroundColorAttributeName value:COL(37, 153, 255, 1) range:NSMakeRange(range.location, answerLength)];
            }
        }
    }
    [mutableString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17]range:NSMakeRange(0, modelContent.length)];
    return mutableString;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _startOffsetX = scrollView.contentOffset.x;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _endOffsetX =scrollView.contentOffset.x;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
