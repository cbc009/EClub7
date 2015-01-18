//
//  UserDetailViewController.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "UserDetailViewController.h"

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
@interface UserDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LoginViewControllerDelegate>
{
    UserDetailService *userDetailService;
    Index3_3Cell *cell1;
    UserInfo *user;
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SharedData *shareData = [SharedData sharedInstance];
    user = shareData.user;
    self.title = @"个人信息";
//    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    } else if (section ==1){
        return 2;
    } else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSString *identifier;
    if (section==0) {
        identifier = @"index3_3Cell";
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1= [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell1.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell1.nickname.text=user.nickname;
        cell1.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgrount.jpg"]];
        cell1.imageview.userInteractionEnabled =YES;
        UITapGestureRecognizer *chageHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer)];
        [cell1.imageview addGestureRecognizer:chageHead];
        cell1.imageview.layer.masksToBounds = YES;
        cell1.imageview.layer.cornerRadius = 40;
        return cell1;
    }else  if (section==1) {
        identifier = @"index3_4Cell";
        index3_4Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userId.text = @"昵称";
            cell.username.hidden=YES;
        } if (indexPath.row==1) {
            if (user.lifehall_id==0) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.userId.text = @"关联区域";
            }else{
                cell.userId.text = user.lifehall_name;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }else if (indexPath.row == 3) {
            cell.userId.text = @"账号";
            cell.username.text = user.mobile;
        }
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
    }
    else {
        return nil;
    }
}

-(void)tapGestureRecognizer
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [action showInView:self.view.window];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSInteger section = indexPath.section;
    if (section ==0) {
      
    }else if (section == 1) {
        if (indexPath.row ==0) {
            [userDetailService presentChangeNameViewControllerOnViewController:self];
        }else if (indexPath.row==1){
             if (user.lifehall_id==0) {
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"User" bundle:nil];
                 ChooseAreaViewController *chooseAreaViewController = [storyboard instantiateViewControllerWithIdentifier:@"ChooseAreaViewController"];
                 chooseAreaViewController.user = user;
                 [self.navigationController pushViewController:chooseAreaViewController animated:YES];
             }else{
//                 [SVProgressHUD showErrorWithStatus:@"您以关联区域"];
             }
        }
    }else if (section == 2) {
        if (indexPath.row ==1){
            [userDetailService presentChangePasswordViewControllerOnViewController:self];
        } else {
            [userDetailService presentChangePayPasswordViewControllerOnViewController:self];
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
            return 59;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 8;
}


- (IBAction)loginout:(id)sender {
    [userDetailService loginoutActionInViewController:self];
}

#pragma LoginViewControllerDelegate
-(void)loginSuccessedActionWithViewController:(UIViewController *)viewController{
    [_tableview reloadData];
    [viewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }else if(buttonIndex==1){
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}


#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
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
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
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
