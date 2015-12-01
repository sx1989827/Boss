//
//  LoginVC.h
//  Boss
//
//  Created by 孙昕 on 15/11/20.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *texUsername;
@property (strong, nonatomic) IBOutlet UITextField *texPwd;
- (IBAction)onLogin:(id)sender;
- (IBAction)onRegister:(id)sender;
- (IBAction)onForgot:(id)sender;

@end
