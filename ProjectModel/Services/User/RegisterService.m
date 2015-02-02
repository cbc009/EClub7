//
//  RegisterService.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RegisterService.h"
#import "SVProgressHUD.h"
#import "InternetRequest.h"
#import "MyMD5.h"
#import "NSString+MT.h"
#import "Status.h"
#import "JSONModelLib.h"
#import "LoginViewController.h"
@implementation RegisterService
/*
    1,验证是否电话号码
 
 */
-(void)sendCodeActionWithLoginname:(NSString *)name onViewController:(RegisterViewController *)viewController{
    if (name==nil||[name isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"号码有误"];
    }else{
        if(![name isValidateMobile:name]){
            [SVProgressHUD showErrorWithStatus:@"手机号码不合法"];
            return ;
    }
        NSString *urlString = [NSString stringWithFormat:ValicodeURL,name];
            [Status getModelFromURLWithString:urlString completion:^(Status *model, JSONModelError *error){
                if (model.status==2) {
                    [SVProgressHUD showSuccessWithStatus:@"发送成功"];
                }else if (model.status==802){
                    [SVProgressHUD dismiss];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"用户已存在" message:@"该手机已注册请直接登录" delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"现在去登录", nil];
                    alertView.alertViewStyle = UIAlertViewStyleDefault;
                    [alertView show];
                }
            }];
        }
}

-(void)registerWithName:name andCode:codeNumber andPasswd:passwd andPasswordConfirm:passwdConfirm andGuide:(NSString *)guide andLifehall_id:(NSString *)lifeHall_id onViewController:(ChooseAreaViewController *)viewController{
        [SVProgressHUD show];
        NSString *password = [MyMD5 md5:passwd];
    if ([guide isEqualToString:@""]) {
        guide=@"13517493217";
    }
    __block NSString * blocknames=name;
    __block NSString *blockPassword = passwd;
        NSString *urlString = [NSString stringWithFormat:Base_Member_Regist_URL,name,password,codeNumber,guide,lifeHall_id];
        NSLog(@"%@",urlString);
        [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
            if (model.status==2) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                if ([viewController.navigationController.viewControllers[0] isKindOfClass:[LoginViewController class]]) {
                    LoginViewController *loginviewController=viewController.navigationController.viewControllers[0];
                    loginviewController.loginname1=blocknames;
                    loginviewController.password1=blockPassword;
                    [viewController.navigationController popToRootViewControllerAnimated:YES];
                }
                }else {
                [SVProgressHUD showErrorWithStatus:model.error];
            }
        }];

}



@end
