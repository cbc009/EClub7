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
@implementation CreatePayService

-(void)loadCreatePayOrderInfoWithMid:(NSInteger )mid andPrice:(NSString *)price finished:(doneWithObject)done{
    if (![self isPureInt:price]) {
        [SVProgressHUD showErrorWithStatus:@"金额必须是整数"];
    }else if([price floatValue]<20){
        [SVProgressHUD showErrorWithStatus:@"一次充值最少20元"];
    }else{
        [SVProgressHUD show];
        NSString *urlString = [NSString stringWithFormat:Create_pay_orderURL,mid,price];
        NSLog(@"%@",urlString);
        [Create_pay_order getModelFromURLWithString:urlString completion:^(Create_pay_order *model,JSONModelError *error){
            if (model.status==2) {
                done(model.info);
                [SVProgressHUD dismiss];
            }else{
//                [SharedAction showErrorWithStatus:model.status witViewController:<#(UIViewController *)#>];
            }
        }];
    }
}

//判断是否微整型
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

-(void)reloadAmoutAfterPopToViewControllerInNav:(UINavigationController *)nav{
    CreatePayViewController *viewController = [nav.viewControllers lastObject];
    UIViewController<CreatePayViewDelegate> *popViewController = nav.viewControllers[nav.viewControllers.count-2];
    viewController.delegate = popViewController;
    [viewController.navigationController popViewControllerAnimated:YES];
    [viewController.delegate reloadAmount];
}
@end
