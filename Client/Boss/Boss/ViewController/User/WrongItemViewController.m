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
@interface WrongItemViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)NSArray *itemArray;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UIScrollView *scrollview;
@end

@implementation WrongItemViewController

- (void)viewDidLoad {
        [super viewDidLoad];
        self.bHud =NO;
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
        obj.username = USERNAME;
        obj.pwd =PWD;
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
        [self creatView];
    } ShowHud:YES];
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
-(void)creatView
{
    for (int i =0; i<self.itemArray.count; i++) {
         UIView*view = [[UIView alloc]init];
        view.frame = CGRectMake((self.view.frame.size.width*i), 0, self.view.frame.size.width, self.view.frame.size.height);
        UITextView*contentTextView = [[UITextView alloc]init];
        contentTextView.font = [UIFont systemFontOfSize:17];
        contentTextView.userInteractionEnabled =NO;
        contentTextView.frame =CGRectMake(10, 10, view.frame.size.width-20, view.frame.size.height-84);
        [view addSubview:contentTextView];
        WrongModel*model = self.itemArray[i];
        NSString *contentSting = [NSString stringWithFormat:@"题目:%@",model.content];
        NSString *answerString = [NSString stringWithFormat:@"答案:%@",model.answer[0][@"ok"]];
        contentTextView.text =[NSString stringWithFormat:@"%@  %@",contentSting,answerString];
        [self.scrollView addSubview:view];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        NSInteger a=scrollView.contentOffset.x/self.view.frame.size.width;
        self.countLabel.text = [NSString stringWithFormat:@"%ld/ %lu",(long)(a+1),(unsigned long)self.itemArray.count];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
