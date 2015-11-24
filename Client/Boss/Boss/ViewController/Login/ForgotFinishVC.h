//
//  ForgotFinishVC.h
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgotFinishVC : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *lbQuestion;
@property (strong, nonatomic) IBOutlet UITextField *texAnswer;
@property (strong, nonatomic) IBOutlet UITextField *texPwd;
@property (strong, nonatomic) IBOutlet UITextField *texPwdRepeat;

- (IBAction)onSubmit:(id)sender;
@property (strong,nonatomic) NSString* question;
@property (strong,nonatomic) NSString* username;
@end
