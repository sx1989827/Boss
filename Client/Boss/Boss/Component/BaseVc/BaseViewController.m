//
//  BaseViewController.m
//  RunMan-User
//
//  Created by 孙昕 on 15/5/19.
//  Copyright (c) 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"
#import <POP.h>
@interface BaseViewController ()<UIScrollViewDelegate>
{
    UIImageView *imageView;
    CGFloat curScrollViewPos;
    CGRect rectNavBar;
    CGFloat oriTop;
    CGFloat oriBottom;
    BOOL bTabShow;
    BOOL bHideBackButton;
    NSInteger iAppearCount;
}
@property (assign,readwrite,nonatomic) BOOL bFirstAppear;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    iAppearCount=0;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationItem setHidesBackButton:YES];
    bHideBackButton=NO;
    _bHud=YES;
    _bAutoHiddenBar=NO;
    _bFirstAppear=YES;
    if(self.hidesBottomBarWhenPushed==YES)
    {
        bTabShow=NO;
    }
    else
    {
        bTabShow=YES;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    iAppearCount++;
    if(iAppearCount==2)
    {
        _bFirstAppear=NO;
    }
    if(!bHideBackButton)
    {
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
        });
        
    }
    if(_bAutoHiddenBar && _bFirstAppear && _viewScrollAutoHidden)
    {
        rectNavBar=self.navigationController.navigationBar.frame;
        NSInteger i=0;
        for(NSLayoutConstraint *con in self.view.constraints)
        {
            if(con.firstAttribute==NSLayoutAttributeTop)
            {
                oriTop=con.constant;
                i++;
            }
            else if(con.firstAttribute==NSLayoutAttributeBottom)
            {
                oriBottom=con.constant;
                i++;
            }
            if(i==2)
            {
                break;
            }
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoHiddenAction) name:@"scrollViewDidScroll" object:nil];
    }
    if(!_bHud)
    {
        return;
    }
    if(imageView==nil)
    {
        imageView=[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        imageView.userInteractionEnabled=YES;
        imageView.backgroundColor=[UIColor whiteColor];
        imageView.contentMode=UIViewContentModeCenter;
        imageView.layer.zPosition=MAXFLOAT;
        imageView.animationImages=@[[UIImage imageNamed:@"HUDLoading1.png"],[UIImage imageNamed:@"HUDLoading2.png"],[UIImage imageNamed:@"HUDLoading3.png"],[UIImage imageNamed:@"HUDLoading4.png"],[UIImage imageNamed:@"HUDLoading5.png"],[UIImage imageNamed:@"HUDLoading6.png"],[UIImage imageNamed:@"HUDLoading7.png"]];
        imageView.animationDuration=1.0;
        imageView.animationRepeatCount=-1;
    }
    imageView.alpha=1;
    [self.view addSubview:imageView];
    [imageView startAnimating];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeHud];
    if(_bAutoHiddenBar && _viewScrollAutoHidden)
    {
        NSInteger i=0;
        for(NSLayoutConstraint *con in self.view.constraints)
        {
            if(con.firstAttribute==NSLayoutAttributeTop)
            {
                con.constant=oriTop;
                i++;
            }
            else if(con.firstAttribute==NSLayoutAttributeBottom)
            {
                con.constant=oriBottom;
                i++;
            }
            if(i==2)
            {
                break;
            }
        }
        if(bTabShow)
        {
            self.tabBarController.tabBar.hidden=NO;
        }
        self.navigationController.navigationBar.frame=rectNavBar;
        for(UIView *view in self.navigationController.navigationBar.subviews)
        {
            if(![view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
            {
                view.hidden=NO;
            }
            
        }
    }
    
}

-(void)autoHiddenAction
{
    int currentPostion = _viewScrollAutoHidden.contentOffset.y;
    
    if (currentPostion - curScrollViewPos > 20  && currentPostion > 0 && _viewScrollAutoHidden.contentSize.height>_viewScrollAutoHidden.bounds.size.height) {
        curScrollViewPos = currentPostion;
        NSInteger i=0;
        for(NSLayoutConstraint *con in self.view.constraints)
        {
            if(con.firstAttribute==NSLayoutAttributeTop)
            {
                con.constant=20;
                i++;
            }
            else if (con.firstAttribute==NSLayoutAttributeBottom)
            {
                con.constant=0;
                i++;
            }
            if(i==2)
            {
                break;
            }
        }
        if(bTabShow)
        {
            self.tabBarController.tabBar.hidden=YES;
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.navigationController.navigationBar.frame=CGRectMake(0, 0, rectNavBar.size.width, 20);
        } completion:^(BOOL finished) {
            for(UIView *view in self.navigationController.navigationBar.subviews)
            {
                if(![view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
                {
                    view.hidden=YES;
                }
            }
        }];
    }
    else if ((curScrollViewPos - currentPostion > 20) && (currentPostion  <= _viewScrollAutoHidden.contentSize.height-_viewScrollAutoHidden.bounds.size.height-5) )
    {
    
        curScrollViewPos = currentPostion;
        NSInteger i=0;
        for(NSLayoutConstraint *con in self.view.constraints)
        {
            if(con.firstAttribute==NSLayoutAttributeTop)
            {
                con.constant=oriTop;
                i++;
            }
            else if(con.firstAttribute==NSLayoutAttributeBottom)
            {
                con.constant=oriBottom;
                i++;
            }
            if(i==2)
            {
                break;
            }
        }
        if(bTabShow)
        {
            self.tabBarController.tabBar.hidden=NO;
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.navigationController.navigationBar.frame=rectNavBar;
        } completion:^(BOOL finished) {
            for(UIView *view in self.navigationController.navigationBar.subviews)
            {
                if(![view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
                {
                    view.hidden=NO;
                }
                
            }
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)onBack
{
	if(self.navigationController.viewControllers.count==1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)hideBackButton
{
    if(self.navigationItem!=nil)
    {
        self.navigationItem.leftBarButtonItem=nil;
        bHideBackButton=YES;
    }
    
}

-(void)removeHud
{
    [imageView stopAnimating];
    POPBasicAnimation *ani=[POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    ani.toValue=@0;
    ani.duration=0.2;
    [ani setCompletionBlock:^(POPAnimation *ani, BOOL bFinish) {
        [imageView removeFromSuperview];
    }];
    [imageView pop_addAnimation:ani forKey:@"hide"];
}

@end









