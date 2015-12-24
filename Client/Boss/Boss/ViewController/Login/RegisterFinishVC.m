//
//  RegisterFinishVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "RegisterFinishVC.h"
#import "Header.h"
#import "SliderView.h"
#import "SGSheetMenu.h"
#import "RegisterReq.h"
@interface RegisterFinishVC ()
{
    NSInteger indexSex;
}
@end

@implementation RegisterFinishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    self.title=@"注册";
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    lb.font=[UIFont systemFontOfSize:15];
    lb.textColor=[UIColor blackColor];
    lb.text=@"密码:";
    _texPwd.leftViewMode=UITextFieldViewModeAlways;
    _texPwd.leftView=lb;
    lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    lb.font=[UIFont systemFontOfSize:15];
    lb.textColor=[UIColor blackColor];
    lb.text=@"重复密码:";
    _texPwdRepeat.leftViewMode=UITextFieldViewModeAlways;
    _texPwdRepeat.leftView=lb;
    lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    lb.font=[UIFont systemFontOfSize:15];
    lb.textColor=[UIColor blackColor];
    lb.text=@"提示问题:";
    _texQuestion.leftViewMode=UITextFieldViewModeAlways;
    _texQuestion.leftView=lb;
    lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    lb.font=[UIFont systemFontOfSize:15];
    lb.textColor=[UIColor blackColor];
    lb.text=@"答案:";
    _texAnswer.leftViewMode=UITextFieldViewModeAlways;
    _texAnswer.leftView=lb;
    lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    lb.font=[UIFont systemFontOfSize:15];
    lb.textColor=[UIColor blackColor];
    lb.text=@"昵称:";
    _texName.leftViewMode=UITextFieldViewModeAlways;
    _texName.leftView=lb;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onRegister:(id)sender
{
    if(_texName.text.length==0)
    {
        E(@"请输入昵称");
        return;
    }
    else if(_texPwd.text.length==0)
    {
        E(@"请输入密码");
        return;
    }
    else if(_texPwdRepeat.text.length==0)
    {
        E(@"请重复输入密码");
        return;
    }
    else if(_texQuestion.text.length==0)
    {
        E(@"请输入提示问题");
        return;
    }
    else if(_texAnswer.text.length==0)
    {
        E(@"请输入答案");
        return;
    }
    else if(![_texPwd.text isEqualToString:_texPwdRepeat.text])
    {
        E(@"两次输入的密码不一致");
        return;
    }
    [TipView showWithTitle:@"提醒" Tip:@"是否确定注册，你所注册的信息将用于积分排名的展示!" YesBlock:^{
        [RegisterReq do:^(id req) {
            RegisterReq *obj=req;
            obj.username=_username;
            obj.name=_texName.text;
            obj.pwd=_texPwd.text;
            obj.question=_texQuestion.text;
            obj.answer=_texAnswer.text;
            obj.time=[[NSDate date] stringValue];
        } Res:^(id res) {
            BaseRes *obj=res;
            if(obj.code==0)
            {
                S(@"注册成功");
                for(UIViewController *vc in self.navigationController.viewControllers)
                {
                    if([vc isKindOfClass:NSClassFromString(@"LoginVC")])
                    {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
            else
            {
                E(obj.msg);
            }
        } ShowHud:YES];
    } NoBlock:nil];
    
}
@end








