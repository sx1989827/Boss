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
    SliderView *viewSlideAge;
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
    viewSlideAge=[[SliderView alloc] initWithFrame:_viewAge.bounds Min:10 Max:50];
    viewSlideAge.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_viewAge addSubview:viewSlideAge];
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


- (IBAction)onSex:(id)sender
{
    [SGActionView showSheetWithTitle:@"请选择您的性别" itemTitles:@[@"男",@"女"] selectedIndex:indexSex selectedHandle:^(NSInteger index) {
        indexSex=index;
       if(index==0)
       {
           _btnSex.text=@"男";
       }
        else
        {
            _btnSex.text=@"女";
        }
    }];
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
    [RegisterReq do:^(id req) {
        RegisterReq *obj=req;
        obj.username=_username;
        obj.name=_texName.text;
        obj.pwd=_texPwd.text;
        obj.age=viewSlideAge.value;
        obj.sex=_btnSex.text;
        obj.question=_texQuestion.text;
        obj.answer=_texAnswer.text;
    } Res:^(id res) {
        BaseRes *obj=res;
        if(obj.code==0)
        {
            S(@"注册成功");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            E(obj.msg);
        }
    } ShowHud:YES];
}
@end








