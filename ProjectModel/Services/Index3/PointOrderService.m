//
//  PointOrderService.m
//  Club
//
//  Created by MartinLi on 14-12-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PointOrderService.h"
#import "SharedAction.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "PointOrder.h"
#import "JSONModelLib.h"
#import "SVProgressHUD.h"
@implementation PointOrderService
/*
 加载我积分兑换的订单
 */
-(void)loadTradeOrderWithToken:(NSString *)token anduser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withdone:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:PointDetialOrder,token,user_type];
    [SVProgressHUD show];
    [PointOrderData getModelFromURLWithString:urlString completion:^(PointOrderData *object,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object.info inTabBarController:tabBarController withDone:done];
    }];
}
@end
