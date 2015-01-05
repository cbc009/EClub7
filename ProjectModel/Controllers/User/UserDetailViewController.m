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
#import "Login.h"
#import "index3_3Cell.h"
#import "index3_4Cell.h"
#import "index3_8Cell.h"
#import "SharedAction.h"
#import <UIImageView+WebCache.h>
@interface UserDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UserDetailService *userDetailService;
    index3_3Cell *cell1;
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
    
    self.title = @"我的信息";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview reloadData];
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
        return 4;
    } else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSString *identifier;
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    if (section==0) {
        identifier = @"index3_3Cell";
        cell1= [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell1.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell1;
    }else  if (section==1) {
        identifier = @"index3_4Cell";
        index3_4Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userId.text = @"昵称";
            cell.username.text = user.nickname;
        } if (indexPath.row==1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userId.text = @"我的地址";
            
        } else if (indexPath.row == 2) {
            cell.userId.text = @"小区";
            cell.username.text = user.sname;
            
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSInteger section = indexPath.section;
    if (section ==0) {
       
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        [action showInView:self.view.window];
    }if (section == 1) {
        if (indexPath.row ==0) {
            [userDetailService presentChangeNameViewControllerOnViewController:self];
        } else if (indexPath.row==1)
        {
            [userDetailService presentChangeAdressViewControllerOnViewController:self];
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
            return 78;
            break;
            
        default:
            return 54;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 5;
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
