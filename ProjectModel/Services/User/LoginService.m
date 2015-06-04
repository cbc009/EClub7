//
//  LoginService.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "LoginService.h"
#import "SVProgressHUD.h"
#import "RegisterViewController.h"

#import "MyMD5.h"
#import "InternetRequest.h"
#import "ChooseAreaViewController.h"
#import "Member_Login.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "SharedData.h"
#import "SharedAction.h"
#import "BuyService.h"
@implementation LoginService
//这个不需要我多说了 吧
-(void)loginWithName:(NSString *)name andPasswd:(NSString *)passwd onViewController:(LoginViewController *)viewController{
    if ([self validateLoginInfosWithName:name andPasswd:passwd]) {
        NSString *password = [MyMD5 md5:passwd];
        NSString *urlString = [NSString stringWithFormat:Login_Member_Login_URL,name,password,@"0",@"0"];
        NSLog(@"%@",urlString);
        [SVProgressHUD show];
        [Member_Login getModelFromURLWithString:urlString completion:^(Member_Login *model,JSONModelError *error){
            if (model.status==2) {
                [self setSharedDataWithUser:model.info andUserName:name andPassWord:password];
                [SharedAction setUMessageTagsWithUser:model.info];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AgentReload"
                                                                    object:nil];
                [self handlesWhenDismissLoginViewController:viewController];
                [SVProgressHUD dismiss];
            }else if (model==nil) {
                    [SVProgressHUD showErrorWithStatus:@"服务器升级中"];
            }else{
                    [SVProgressHUD showErrorWithStatus:model.error];
                }
        }];
        
    }
}
//看名字也知道这是设置用户信息
-(void)setSharedDataWithUser:(UserInfo *)user andUserName:(NSString *)username andPassWord:(NSString *)password{
    SharedData *sharedData = [SharedData sharedInstance];
    sharedData.user = user;
    sharedData.loginname = username;
    sharedData.password = password;
    sharedData.loginStatus = @"YES";
}
//跳转注册页面
-(void)pushRegisterViewControllerOnViewController:(LoginViewController *)viewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    registerViewController = [storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [viewController.navigationController pushViewController:registerViewController animated:YES];
}

//验证登录
-(BOOL)validateLoginInfosWithName:(NSString *)name andPasswd:(NSString *)passwd{
    if ([name isEqualToString:@""]||name==nil) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return false;
    }else if([passwd isEqualToString:@""]||passwd==nil){
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return false;
    }else{
        return true;
    }
}

//dismiss LoginViewController时处理操作
-(void)handlesWhenDismissLoginViewController:(LoginViewController *)loginViewContrller{
    
    [loginViewContrller.delegate loginSuccessedActionWithViewController:loginViewContrller];  //dismiss viewcontroller
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];  //loadData
}

@end
