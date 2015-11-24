//
//  RegisterVC.h
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *texUsername;
- (IBAction)onNext:(id)sender;

@end
