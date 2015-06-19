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

-(void)sendCodeACtionWithLoginname:(NSString *)name inTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done{
    if (name==nil||[name isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"号码有误"];
    }else{
        if(![name isValidateMobile:name]){
            [SVProgressHUD showErrorWithStatus:@"手机号码不合法"];
            return ;
        }
        NSString *urlString = [NSString stringWithFormat:ValicodeURL,name];
        [Status getModelFromURLWithString:urlString completion:^(Status *model, JSONModelError *error){
            if (model.status==802) {
                done(model);
            }else{
            [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
            }
            }];
        }
}

-(void)registerWithName:name andCode:codeNumber andPasswd:passwd andPasswordConfirm:passwdConfirm andGuide:(NSString *)guide andLifehall_id:(NSString *)lifeHall_id inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *password = [MyMD5 md5:passwd];
    if ([guide isEqualToString:@""]) {
        guide=@"18073322955";
    }
    NSString *urlString = [NSString stringWithFormat:Base_Member_Regist_URL,name,password,codeNumber,guide,lifeHall_id];
    [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
      }];

}
@end
