//
//  ForgotFinishVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ForgotFinishVC.h"
#import "ResetPwdReq.h"
#import "Header.h"
@interface ForgotFinishVC ()

@end

@implementation ForgotFinishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"找回密码";
    self.bHud=NO;
    _lbQuestion.text=_question;
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    lb.text=@"答案:";
    lb.textColor=[UIColor blackColor];
    lb.font=[UIFont systemFontOfSize:15];
    _texAnswer.leftViewMode=UITextFieldViewModeAlways;
    _texAnswer.leftView=lb;
    lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    lb.text=@"新密码:";
    lb.textColor=[UIColor blackColor];
    lb.font=[UIFont systemFontOfSize:15];
    _texPwd.leftViewMode=UITextFieldViewModeAlways;
    _texPwd.leftView=lb;
    lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    lb.text=@"重复新密码:";
    lb.textColor=[UIColor blackColor];
    lb.font=[UIFont systemFontOfSize:15];
    _texPwdRepeat.leftViewMode=UITextFieldViewModeAlways;
    _texPwdRepeat.leftView=lb;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onSubmit:(id)sender
{
    if(_texAnswer.text.length==0)
    {
        E(@"请输入答案");
        return;
    }
    else if(_texPwd.text.length==0)
    {
        E(@"请输入新密码");
        return;
    }
    else if(_texPwdRepeat.text.length==0)
    {
        E(@"请重复输入新密码");
        return;
    }
    else if(![_texPwd.text isEqualToString:_texPwdRepeat.text])
    {
        E(@"两次密码输入不一致");
        return;
    }
    [ResetPwdReq do:^(id req) {
        ResetPwdReq *obj=req;
        obj.username=_username;
        obj.answer=_texAnswer.text;
        obj.pwd=_texPwd.text;
    } Res:^(id res) {
        BaseRes *obj=res;
        if(obj.code==0)
        {
            S(@"修改成功");
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
}
@end







