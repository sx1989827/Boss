//
//  EditPswViewController.m
//  Boss
//
//  Created by libruce on 15/12/7.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "EditPswViewController.h"
#import "Util.h"
#import "Header.h"
#import "EditPswReq.h"
@interface EditPswViewController ()
@property (strong, nonatomic) IBOutlet UITextField *oldPswField;
@property (strong, nonatomic) IBOutlet UITextField *recentlyPswField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPswField;
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@end

@implementation EditPswViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.headImageView.layer.masksToBounds =YES;
    self.headImageView.layer.cornerRadius =45;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",serverUrl,[UserDefaults sharedInstance].resModel.data.photo]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud =NO;
    self.title =@"修改密码";
}
- (IBAction)submit:(id)sender {
    if(_oldPswField.text.length==0||_recentlyPswField.text.length==0||_confirmPswField.text.length==0)
    {
        E(@"不能有空得选项！");
        return;
    }
    else if (![_confirmPswField.text isEqualToString:_recentlyPswField.text])
    {
         E(@"两次密码不一致！");
    }
    else
    {
        [EditPswReq do:^(id req) {
            EditPswReq *obj=req;
            obj.newpwd=_recentlyPswField.text;
        } Res:^(id res) {
            BaseRes *obj=res;
            if(obj.code==0)
            {
                S(obj.msg);
                [UserDefaults sharedInstance].resModel.data.pwd=_recentlyPswField.text;
                [[UserDefaults sharedInstance] synchronize];
                [self.navigationController popViewControllerAnimated:YES];
               
            }
            else
            {
                E(obj.msg);
            }
        } ShowHud:YES];
        return;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
