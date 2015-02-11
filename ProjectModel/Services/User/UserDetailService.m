//
//  UserDetailService.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "UserDetailService.h"
#import "SharedAction.h"
#import "UserDefaults.h"
#import "ChangePayPasswordViewController.h"
#import "ChangePasswordViewController.h"
#import "ChangeNameViewController.h"
#import "ChangeAdressViewController.h"
#import "SharedData.h"
@implementation UserDetailService

/*
 1,设置login status 为注销状态
 2,调出loginViewController界面
 */
-(void)loginoutActionInViewController:(UserDetailViewController *)viewController inTabBarController:(UITabBarController *)tabBarController{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [SharedAction presentLoginViewControllerInViewController:viewController];
}

//修改头像
-(void)updateHeaderImage:(UIImage *)image withCompletion:(finished)finished{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *user_type = [NSString stringWithFormat:@"%ld",(long)user.user_type];
    NSMutableDictionary *parameters = (NSMutableDictionary *)@{@"token":user.token,@"user_type":user_type};
    [SharedAction callAPI:[NSString stringWithFormat:@"%@%@",IP,@"/wap.php/Base/head"] parameters:parameters name:@"picture" image:image withCompletion:^(BOOL complete,NSDictionary *info){
        if (complete) {
            finished(info);
        }
    }];
}

//修改支付密码
-(void)presentChangePayPasswordViewControllerOnViewController:(UIViewController *)viewController{
    ChangePayPasswordViewController *changePayViewController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"ChangePayPasswordViewController"];
    changePayViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:changePayViewController animated:YES];
}
//修改登录密码
-(void)presentChangePasswordViewControllerOnViewController:(UIViewController *)viewController{
    ChangePasswordViewController *changePassworViewController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    changePassworViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:changePassworViewController animated:YES];
}
//修改昵称
-(void)presentChangeNameViewControllerOnViewController:(UIViewController *)viewController
{
    ChangeNameViewController *changeNameViewController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"ChangeNameViewController"];
    [viewController.navigationController pushViewController:changeNameViewController animated:YES];
    
}
//修改我的地址
-(void)presentChangeAdressViewControllerOnViewController:(UIViewController *)viewController
{
    ChangeAdressViewController *changeAdressViewController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"ChangeAdressViewController"];
    [viewController.navigationController pushViewController:changeAdressViewController animated:YES];
    
}

@end
