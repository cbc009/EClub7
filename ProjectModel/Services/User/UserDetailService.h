//
//  UserDetailService.h
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDetailViewController.h"

@interface UserDetailService : NSObject

//退出
-(void)loginoutActionInViewController:(UserDetailViewController *)viewController inTabBarController:(UITabBarController *)tabBarController;
//上传用户头像
-(void)updateHeaderImage:(UIImage *)image withCompletion:(finished)finished;
//修改支付密码
-(void)presentChangePayPasswordWithOldPassword:(NSString *)oldPassword inViewControllerOnViewController:(UIViewController *)viewController;
//修改登录密码
-(void)presentChangePasswordWithOldPassword:(NSString *)oldPassword inViewControllerOnViewController:(UIViewController *)viewController;
//修改昵称
-(void)presentChangeNameViewControllerOnViewController:(UIViewController *)viewController;
//修改地址
-(void)presentChangeAdressViewControllerOnViewController:(UIViewController *)viewController;
@end
