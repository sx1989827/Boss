//
//  LoginVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/20.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "LoginVC.h"
#import "CheckUserNameReq.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [CheckUserNameReq do:^(id req) {
        CheckUserNameReq *obj=req;
        obj.username=@"sx1989827";
    } Res:^(id res) {
        CheckUserNameRes *obj=res;
        if(obj.code==0)
        {
            NSLog(@"%ld",obj.data);
        }
    } Err:nil ShowHud:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
