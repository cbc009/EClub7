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


-(void)loginoutActionInViewController:(UserDetailViewController *)viewController inTabBarController:(UITabBarController *)tabBarController;
-(void)updateHeaderImage:(UIImage *)image inTabBarController:(UITabBarController *)tabBarController withCompletion:(finished)finished;
-(void)presentChangePayPasswordViewControllerOnViewController:(UIViewController *)viewController;
-(void)presentChangePasswordViewControllerOnViewController:(UIViewController *)viewController;
-(void)presentChangeNameViewControllerOnViewController:(UIViewController *)viewController;
-(void)presentChangeAdressViewControllerOnViewController:(UIViewController *)viewController;
@end
