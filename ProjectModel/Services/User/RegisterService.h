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
-(void)registerWithName:name andCode:codeNumber andPasswd:passwd andPasswordConfirm:passwdConfirm andGuide:(NSString *)guide andLifehall_id:(NSString *)lifeHall_id onViewController:(ChooseAreaViewController *)viewController;
-(void)sendCodeActionWithLoginname:(NSString *)name onViewController:(RegisterViewController *)viewController;
@end
