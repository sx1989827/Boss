//
//  ForgotVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ForgotVC.h"
#import "Header.h"
#import "UserQuestionReq.h"
@interface ForgotVC ()

@end

@implementation ForgotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    self.title=@"找回密码";
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    lb.font=[UIFont systemFontOfSize:14];
    lb.text=@"用户名:";
    lb.textColor=[UIColor blackColor];
    _texUsername.leftView=lb;
    _texUsername.leftViewMode=UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onNext:(id)sender
{
    if(_texUsername.text.length==0)
    {
        E(@"请输入你要找回的用户名");
        return;
    }
    [UserQuestionReq do:^(id req) {
        UserQuestionReq *obj=req;
        obj.username=_texUsername.text;
    } Res:^(id res) {
        UserQuestionRes *obj=res;
        if(obj.code==0)
        {
            [self pushViewController:@"ForgotFinishVC" Param:@{@"question":obj.data,@"username":_texUsername.text}];
        }
        else
        {
            E(obj.msg);
        }
    } ShowHud:YES];
}
@end









