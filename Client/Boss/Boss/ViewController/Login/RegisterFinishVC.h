//
//  RegisterFinishVC.h
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterFinishVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *texPwd;
@property (strong, nonatomic) IBOutlet UITextField *texPwdRepeat;
@property (strong, nonatomic) IBOutlet UIView *viewAge;
@property (strong, nonatomic) IBOutlet UIButton *btnSex;
- (IBAction)onSex:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *texQuestion;
@property (strong, nonatomic) IBOutlet UITextField *texAnswer;
- (IBAction)onRegister:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *texName;

@property (strong,nonatomic) NSString* username;
@end
