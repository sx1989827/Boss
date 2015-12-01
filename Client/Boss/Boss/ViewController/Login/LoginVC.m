//
//  LoginVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/20.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "LoginVC.h"
#import "Header.h"
#import "LoginInputView.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    LoginInputView *view=[[LoginInputView alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    view.title=@"账号:";
    view.imgName=@"username";
    _texUsername.leftView=view;
    _texUsername.leftViewMode=UITextFieldViewModeAlways;
    view=[[LoginInputView alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    view.title=@"密码:";
    view.imgName=@"pwd";
    _texPwd.leftView=view;
    _texPwd.leftViewMode=UITextFieldViewModeAlways;
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"pwdnosee"] forState:UIControlStateNormal];
    _texPwd.rightView=btn;
    _texPwd.rightViewMode=UITextFieldViewModeAlways;
    btn.tag=0;
    [btn addTarget:self action:@selector(switchSee:) forControlEvents:UIControlEventTouchUpInside];
    btn.imageView.contentMode=UIViewContentModeCenter;
}

-(void)switchSee:(UIButton*)btn
{
    if(btn.tag==0)
    {
        btn.tag=1;
        [btn setImage:[UIImage imageNamed:@"pwdsee"] forState:UIControlStateNormal];
        _texPwd.secureTextEntry=NO;
    }
    else
    {
        btn.tag=0;
        [btn setImage:[UIImage imageNamed:@"pwdnosee"] forState:UIControlStateNormal];
        _texPwd.secureTextEntry=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}

- (IBAction)onLogin:(id)sender
{
    if(_texUsername.text.length==0)
    {
        E(@"请输入用户名");
        return;
    }
    else if(_texPwd.text.length==0)
    {
        E(@"请输入密码");
        return;
    }
    [[UserDefaults sharedInstance] update:_texUsername.text Pwd:_texPwd.text SucBlock:^(UserInfoModel *model) {
        S(@"登陆成功");
    } FailBlock:^(NSString *msg) {
        E(msg);
    } Hud:YES];
}

- (IBAction)onRegister:(id)sender
{
    [self pushViewController:@"RegisterVC" Param:nil];
}

- (IBAction)onForgot:(id)sender
{
    [self pushViewController:@"ForgotVC" Param:nil];
}
@end







