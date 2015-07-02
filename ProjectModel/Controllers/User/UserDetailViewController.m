//
//  UserDetailViewController.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "UserDetailViewController.h"
#import "MyMD5.h"
#import "UserDetailService.h"
#import "UserDefaults.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "Index3_3Cell.h"
#import "index3_4Cell.h"
#import "index3_8Cell.h"
#import "SharedAction.h"
#import <UIImageView+WebCache.h>
#import "ChooseAreaViewController.h"
#import <SVProgressHUD.h>
#import "Status.h"
@interface UserDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LoginViewControllerDelegate,UIAlertViewDelegate>
{
    UserDetailService *userDetailService;
    Index3_3Cell *cell1;
    UserInfo *user;
    SharedData *shareData;
}
@end

@implementation UserDetailViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        userDetailService = [[UserDetailService alloc] init];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.tableFooterView=[UIView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    shareData= [SharedData sharedInstance];
    user = shareData.user;
    self.title = @"个人信息";
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    } else if (section ==1){
        return 1;
    } else if (section==2){
        return 2;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSString *identifier;
    if (section==0) {
        identifier = @"index3_3Cell";
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1= [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell1.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.picture]] placeholderImage:[UIImage imageNamed:@"headss.png"]];
        cell1.nickname.text=user.nickname;
//        [cell1.backImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.life_picture]] placeholderImage:[UIImage imageNamed:@"e"]];
//        cell1.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgrount.jpg"]];
        cell1.imageview.userInteractionEnabled =YES;
        UITapGestureRecognizer *chageHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer)];
        [cell1.imageview addGestureRecognizer:chageHead];
        cell1.imageview.layer.masksToBounds = YES;
        cell1.imageview.layer.cornerRadius = 40;
        return cell1;
    }else  if (section==1) {
        identifier = @"index3_4Cell";
        index3_4Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userId.text = @"昵称";
            cell.username.hidden=YES;
        return cell;
    }else  if (section==2) {
        identifier = @"index3_8Cell";
        index3_8Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (indexPath.row ==0) {
            cell.userId.text = @"修改支付密码";
        } else {
            cell.userId.text = @"修改登录密码";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else  if (section==4) {
        identifier = @"index3_8Cell";
        index3_8Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if ([shareData.loginStatus isEqualToString:@"YES"]) {
            cell.userId.text=@"切换账号";
        }else{
           cell.userId.text=@"登录";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if(section==3) {
        identifier = @"index3_8Cell";
        index3_8Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.userId.text = @"修改地址";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    }else{
        return nil;
    }
}

-(void)tapGestureRecognizer
{
    if (user.user_type==1) {
         [SharedAction showErrorWithStatus:827 andError:@"需要注册以后才能使用该功能" witViewController:self.tabBarController];
    }else{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [action showInView:self.view.window];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    if (section ==0) {
    }else if (section == 1) {
            [userDetailService presentChangeNameViewControllerOnViewController:self];
    }else if (section == 2) {
        if (indexPath.row ==1){
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"验证原密码" message:@"为保障你的数据安全，修改密码前请填写原密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
            alertView.tag=1;
            [alertView show];
        } else{
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"验证原支付密码密码" message:@"为保障你的数据安全，修改支付密码前请填写原支付密码密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
            alertView.tag=2;
            [alertView show];
        }
    }else if (section == 4) {
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"切换账号" message:@"是否要退出当前账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag=3;
        [alertView show];
    }else if(section ==3){
        [userDetailService presentChangeAdressViewControllerOnViewController:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex==1) {
        NSString *passwd= [MyMD5 md5:[[alertView textFieldAtIndex:0] text]];
            [SharedAction confirmPssswordWithToken:user.token andUser_type:user.user_type andType:@"1" andPassword:passwd inTabBarController:self.tabBarController withDone:^(Status *model){
                if (model.status==2) {
                    [userDetailService presentChangePasswordWithOldPassword:[[alertView textFieldAtIndex:0] text] inViewControllerOnViewController:self];
                }
            }];
        }
    }else if(alertView.tag==2){
        if (buttonIndex==1) {
            NSString *passwd= [MyMD5 md5:[[alertView textFieldAtIndex:0] text]];
            [SharedAction confirmPssswordWithToken:user.token andUser_type:user.user_type andType:@"2" andPassword:passwd inTabBarController:self.tabBarController withDone:^(Status *model){
                if (model.status==2) {
                     [userDetailService presentChangePayPasswordWithOldPassword:[[alertView textFieldAtIndex:0] text] inViewControllerOnViewController:self];
                }
            }];
        }
    }else{
        if (buttonIndex==1) {
            [userDetailService loginoutActionInViewController:self inTabBarController:self.tabBarController];
        }
    }
}
             
             
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
            return 145;
            break;
        default:
            return 41;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 0;
}

//
//- (IBAction)loginout:(id)sender {
//    [userDetailService loginoutActionInViewController:self inTabBarController:self.tabBarController];
//}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }else if(buttonIndex==1){
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}


#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    UIImage *image=nil;
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    [userDetailService updateHeaderImage:image withCompletion:^(NSDictionary *info){
        [picker dismissViewControllerAnimated:YES completion:^{
            NSString *picture = info[@"picture"];
            SharedData *sharedData = [SharedData sharedInstance];
            sharedData.user.picture = picture;
            [self.tableview reloadData];
        }];
    }];
}

-(void)showImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma Notification
/*
 1，在当前viewcontroller loadData
 */
//-(void)loginSuccessAction:(NSNotification *)nc{
//    [_tableview reloadData];
//    [self loadData];
//}

//加载数据
-(void)loadData{
}



@end
