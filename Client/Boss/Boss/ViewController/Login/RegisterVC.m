//
//  RegisterVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "RegisterVC.h"
#import "Header.h"
#import "CheckUserNameReq.h"
@interface RegisterVC ()

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    self.title=@"注册";
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
    [self.view endEditing:YES];
    if(_texUsername.text.length==0)
    {
        E(@"请输入用户名");
        return;
    }
    [CheckUserNameReq do:^(id req) {
        CheckUserNameReq *obj=req;
        obj.username=_texUsername.text;
    } Res:^(id res) {
        CheckUserNameRes *obj=res;
        if(obj.code==0)
        {
            if([obj.data integerValue]==0)
            {
                [self pushViewController:@"RegisterFinishVC" Param:@{
                                                                     @"username":_texUsername.text
                                                                     }];
            }
            else
            {
                E(@"该用户已注册");
            }
        }
        else
        {
            E(obj.msg);
        }
    } ShowHud:YES];
}
@end









