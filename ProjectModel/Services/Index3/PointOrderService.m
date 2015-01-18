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
-(void)loadTradeOrderInViewController:(PointOrdViewController *)viewController
{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    
    NSString *urlString = [NSString stringWithFormat:PointDetialOrder,user.token,user.user_type];
    NSLog(@"%@",urlString);
    [SharedAction show];
    [PointOrderData getModelFromURLWithString:urlString completion:^(PointOrderData *object,JSONModelError *error){
        if (!error) {
            NSInteger status = object.status;
            if (status==2) {
                viewController.datas = [NSMutableArray arrayWithArray:object.info.order];
            [SharedAction dismiss];
            }else {
                [SVProgressHUD showErrorWithStatus:object.error];
            }
        } else{
                viewController.datas = nil;
            [SVProgressHUD showErrorWithStatus:object.error];
                NSLog(@"%@",error);
            }
        [viewController.tableView reloadData];
    }];
}
@end
