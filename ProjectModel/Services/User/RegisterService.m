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
@implementation RegisterService

/*
    1,验证是否电话号码
 
 */
-(void)sendCodeActionWithLoginname:(NSString *)name onViewController:(RegisterViewController *)viewController{
    if (name==nil||[name isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"号码有误"];
    }else{
        [SVProgressHUD show];
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


-(void)registerWithName:name andCode:codeNumber andPasswd:passwd andPasswordConfirm:passwdConfirm andGuide:(NSString *)guide onViewController:(RegisterViewController *)viewController{
    if ([self validateRegisterName:name andCode:codeNumber andPasswd:passwd andPasswordConfirm:passwdConfirm inViewController:viewController]) {
        [SVProgressHUD show];
        NSString *password = [MyMD5 md5:passwd];
        NSString *urlString = [NSString stringWithFormat:Base_Member_Regist_URL,name,password,codeNumber,guide];
        [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
            if (model.status==2) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                [viewController.navigationController popViewControllerAnimated:YES];
                [viewController.delegate registerSuccessWithLoginname:name andPasswd:passwd];
            }else {
                [SVProgressHUD showErrorWithStatus:@"注册失败"];
            }
        }];
    }
}


/*
 验证注册信息
 */
-(BOOL)validateRegisterName:(NSString*)name andCode:(NSString *)codeNumber andPasswd:(NSString *)passwd andPasswordConfirm:(NSString *)passwdConfirm inViewController:(RegisterViewController *)viewController{
    if ([name isEqualToString:@""]||name==nil) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return NO;
    }else if(![name isValidateMobile:name]){
        [SVProgressHUD showErrorWithStatus:@"手机号码不合法"];
        return NO;
    }else if([codeNumber isEqualToString:@""]||codeNumber==nil){
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        return NO;
    }else if([passwd isEqualToString:@""]||passwd==nil){
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return NO;
    }else if([passwdConfirm isEqualToString:@""]||passwdConfirm==nil||![passwdConfirm isEqualToString:passwd]){
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
        return NO;
    }else if(viewController.checkButton.tag==-1){
        [SVProgressHUD showErrorWithStatus:@"需要同意E小区服务协议"];
        return NO;
    }else{
        return YES;
    }
}
@end
