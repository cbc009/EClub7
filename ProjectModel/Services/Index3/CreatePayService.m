//
//  CreatePayService.m
//  Club
//
//  Created by Gao Huang on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "CreatePayService.h"
#import "Create_pay_order.h"
#import "JSONModelLib.h"
#import "SVProgressHUD.h"
#import "CreatePayViewController.h"
#import "SharedAction.h"
#import "UPay_Order.h"
@implementation CreatePayService

-(void)create_orderWithToken:(NSString *)token andUserType:(NSInteger)userType andPrice:(NSString *)price andPayModel:(NSString *)payModel inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:Create_pay_orderURL,token,userType,price,payModel];
    if (![self isPureInt:price]) {
        [SVProgressHUD showErrorWithStatus:@"金额必须是整数"];
    }else if([price floatValue]<20){
        [SVProgressHUD showErrorWithStatus:@"一次充值最少20元"];
    }else if ([payModel isEqualToString:@"PAY_BAO"]) {
        [Create_pay_order getModelFromURLWithString:urlString completion:^(Create_pay_order *model,JSONModelError *error){
            [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
        }];
    }else if([payModel isEqualToString:@"PAY_UNION"]){
        [UPay_Order getModelFromURLWithString:urlString completion:^(UPay_Order *model,JSONModelError *error){
            [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
        }];
    }
}


//判断是否微整型
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

-(void)pushToMyWalletViewControllerInTabBarController:(UITabBarController *)tabBarController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    UIViewController *walletViewController = [storyboard instantiateViewControllerWithIdentifier:@"MyWalletViewController"];
    walletViewController.hidesBottomBarWhenPushed = YES;
    tabBarController.selectedIndex = 0;
    UINavigationController *nav = tabBarController.viewControllers[tabBarController.selectedIndex];
    [nav popToRootViewControllerAnimated:YES];
    [nav pushViewController:walletViewController animated:YES];
}
@end
