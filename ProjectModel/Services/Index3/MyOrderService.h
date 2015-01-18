//
//  MyOrderService.h
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyOrderViewController.h"
#import "TradeOrderData.h"
#import "TradeOrderDetailViewController.h"
@interface MyOrderService : NSObject
-(void)goodsOrderDetailWithToken:(NSString *)token andUser_type:(NSInteger )user_type andTabViewController:(UITabBarController *)tabbarController andOrderid:(NSString *)orderid witdone:(doneWithObject)done;
-(void)goodsOrderReturnwithToken:(NSString *)token andUser_type:(NSInteger )user_type andOrderid:(NSString *)orderid inTabbarViewController:(UITabBarController *)tabbarController withDone:(doneWithObject)done;
-(void)loadOrderWithPage:(NSString *)pageString andToken:(NSString *)token andUser_type:(NSInteger)user_type andSelectedSegmentIndex:(NSInteger)selectedSegmentIndex inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
