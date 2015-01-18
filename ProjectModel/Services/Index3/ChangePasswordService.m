//
//  ChangePasswordService.m
//  Club
//
//  Created by apple on 14-11-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ChangePasswordService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "MyMD5.h"
#import "InternetRequest.h"
#import "SVProgressHUD.h"
#import "Status.h"
#import "Club-Prefix.pch"
#import "JSONModelLib.h"
@implementation ChangePasswordService

-(void)changePassword:(NSString *)oldpassword andnewPassword:(NSString *)newpasswd andnewpassword2:(NSString *)newpassword2 onChangePasswordViewcontroller:(ChangePasswordViewController *)ChangePasswordViewController
{
    
    BOOL ret = [newpassword2 isEqualToString:newpasswd];
    if (ret) {
        NSString *passwd1 = [MyMD5 md5:oldpassword];
        NSString *passwd2 = [MyMD5 md5:newpasswd];
        SharedData *sharedData = [SharedData sharedInstance];
        UserInfo *user = sharedData.user;
        NSString *urlString = [NSString stringWithFormat:ChangePassword,user.token,user.user_type,passwd2,passwd1];
        [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
            if (model.status==2) {
                [SVProgressHUD showSuccessWithStatus:model.error];
                [ChangePasswordViewController.navigationController popViewControllerAnimated:YES];
            }else if (model.status == 807){
                [SVProgressHUD showErrorWithStatus:model.error];
            }
        }];
    } else{
        [SVProgressHUD dismiss];
    }
}
@end
