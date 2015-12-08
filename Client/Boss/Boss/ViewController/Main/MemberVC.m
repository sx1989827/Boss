//
//  MemberVC.m
//  Boss
//
//  Created by 孙昕 on 15/11/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "MemberVC.h"
#import "Header.h"
#import "SGSheetMenu.h"
#import "EditPhotoReq.h"
#import "EditNameReq.h"
#import "UserDefaults.h"
#import "TipView.h"
#import "EditPswReq.h"
@interface MemberVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation MemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    [self hideBackButton];
    [_tableMain setDelegateAndDataSource:self];
    [_tableMain registarCell:NSStringFromClass([UITableViewCell class]) StrItem:nil];
    LazyTableBaseSection *sec=[[LazyTableBaseSection alloc] init];
    sec.headerHeight=15;
    [_tableMain addSection:sec];
     __weak MemberVC *weakSelf = self;
    [_tableMain addStaticCell:40 CellBlock:^(id cell) {
        UITableViewCell *cl=cell;
        cl.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cl.imageView.image=[UIImage imageNamed:@"rankhistory"];
        cl.textLabel.text=@"闯关记录";
    } ClickBlock:^(id cell) {
        


        [weakSelf pushViewController:@"RecodeHistoryViewController" Param:@{@"type":@"iOS"}];
        
    }];
    [_tableMain addStaticCell:40 CellBlock:^(id cell) {
        UITableViewCell *cl=cell;
        cl.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cl.imageView.image=[UIImage imageNamed:@"editpwd"];
        cl.textLabel.text=@"修改密码";
    } ClickBlock:^(id cell) {
        
       
        [weakSelf pushViewController:@"EditPswViewController" Param:nil];
        

    }];
    [_tableMain addStaticCell:40 CellBlock:^(id cell) {
        UITableViewCell *cl=cell;
        cl.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cl.imageView.image=[UIImage imageNamed:@"aboutus"];
        cl.textLabel.text=@"关于我们";
    } ClickBlock:^(id cell) {
        
        
        
    }];
    [_tableMain addStaticCell:40 CellBlock:^(id cell) {
        UITableViewCell *cl=cell;
        cl.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cl.imageView.image=[UIImage imageNamed:@"aboutus"];
        cl.textLabel.text=@"退出登陆";
    } ClickBlock:^(id cell) {
        [TipView showWithTitle:@"确定退出？" Tip:@"你就这么忍心点YES？" YesBlock:^{
            UserDefaults *user = [UserDefaults sharedInstance];
            user.resModel = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userModel"];
            Class cls=NSClassFromString(@"LoginVC");
            UIViewController *vc=[[cls alloc] init];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:vc];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController=nav;
        } NoBlock:^{
        }];
    }];
    [_tableMain reloadStatic];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    [_btnPhoto sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",serverUrl,[UserDefaults sharedInstance].resModel.data.photo]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _btnPhoto.layer.masksToBounds=YES;
    _btnPhoto.layer.cornerRadius=35;
    _btnPhoto.layer.borderWidth=1;
    _btnPhoto.layer.borderColor=[UIColor grayColor].CGColor;
    _btnName.text=[UserDefaults sharedInstance].resModel.data.name;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
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

- (IBAction)onPhoto:(id)sender
{
    [SGActionView showSheetWithTitle:@"请选择图片来源" itemTitles:@[@"相机",@"相册"] selectedIndex:-1 selectedHandle:^(NSInteger index) {
        UIImagePickerControllerSourceType sourceType;
        if(index==0)
        {
            sourceType=UIImagePickerControllerSourceTypeCamera;
        }else if(index==1)
        {
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }else
        {
            return;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.sourceType = sourceType;
        picker.allowsEditing=YES;
        [self presentViewController:picker animated:YES completion:nil];
    }];
}
- (IBAction)onName:(id)sender
{
    [InputView showWithTitle:@"修改昵称" TextPlaceHolder:@"请输入新的昵称" Block:^BOOL(NSString *text) {
        if(text.length==0)
        {
            S(@"请输入昵称");
            return NO;
        }
        else
        {
            [EditNameReq do:^(id req) {
                EditNameReq *obj=req;
                obj.name=text;
            } Res:^(id res) {
                BaseRes *obj=res;
                if(obj.code==0)
                {
                    S(@"修改成功");
                    _btnName.text=text;
                    [UserDefaults sharedInstance].resModel.data.name=text;
                }
                else
                {
                    E(obj.msg);
                }
            } ShowHud:YES];
            return YES;
        }
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [EditPhotoReq do:^(id req) {
        EditPhotoReq *obj=req;
        obj.file=UIImageJPEGRepresentation(image, 0.5);
    } Res:^(id res) {
        EditPhotoRes *obj=res;
        if(obj.code==0)
        {
            S(@"修改成功");
            [_btnPhoto setBackgroundImage:image forState:UIControlStateNormal];
            [UserDefaults sharedInstance].resModel.data.photo=obj.data;
        }
        else
        {
            E(obj.msg);
        }
    } ShowHud:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end









