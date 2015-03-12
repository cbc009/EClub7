//
//  RegisterService.h
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterViewController.h"
#import "ChooseAreaViewController.h"
@interface RegisterService : NSObject
//注册
-(void)registerWithName:name andCode:codeNumber andPasswd:passwd andPasswordConfirm:passwdConfirm andGuide:(NSString *)guide andLifehall_id:(NSString *)lifeHall_id onViewController:(ChooseAreaViewController *)viewController;
//发送验证码
-(void)sendCodeActionWithLoginname:(NSString *)name onViewController:(RegisterViewController *)viewController;
@end
