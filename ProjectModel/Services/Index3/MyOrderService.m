//
//  MyOrderService.m
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "MyOrderService.h"
#import "SharedData.h"
#import "Login.h"
#import "RobOrderData.h"
#import "JSONModelLib.h"
#import "OrderDetailData.h"
#import "MyGroups.h"
#import "MySecond.h"
#import "SharedAction.h"
@implementation MyOrderService

/*
 加载我购买的订单
 */
-(void)loadTradeWithPage:(NSInteger )page OrderInViewController:(MyOrderViewController *)viewController{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    NSString *urlString = [NSString stringWithFormat:TradeOrderURL,user.token,user.user_type,pageString];
    NSLog(@"%@",urlString);
    [SharedAction show];
    TradeOrderData *orderData = [[TradeOrderData alloc] initFromURLWithString:urlString completion:^(TradeOrderData *object,JSONModelError *error){
        NSLog(@"%@",orderData);
        if (!error) {
            NSInteger status = object.status;
            if (status==2) {
                TradeOrderInfo *info = object.info;
                NSArray *orders = info.order;
                viewController.items = orders;
                [SharedAction dismiss];
            }else if(status==840){
                viewController.items = nil;
                [SharedAction showErrorWithStatus:status witViewController:viewController];
            }else{
                viewController.items = nil;
                [SharedAction showErrorDataError];
            }
        }else{
            viewController.items = nil;
            [SharedAction showErrorNoData];
            NSLog(@"%@",error);
        }
        viewController.orderType = TradeOrderType;
        [viewController.tableview reloadData];
    }];
}
/*
 加载抢菜订单
 */
-(void)loadRobOrderInViewController:(MyOrderViewController *)viewController{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    
    NSString *page = @"1";
    NSString *urlString = [NSString stringWithFormat:RobOrderURL,user.mid,page];
    NSLog(@"%@",urlString);
    [SharedAction show];
    RobOrderData *robOrderData = [[RobOrderData alloc] initFromURLWithString:urlString completion:^(RobOrderData *object,JSONModelError *error){
        NSLog(@"%@",robOrderData);
        if (!error) {
            NSInteger status = object.status;
            if (status==2) {
                RobOrderInfo *info = object.info;
                NSArray *orders = info.order;
                viewController.items = orders;
                [SharedAction dismiss];
            }else if(status==840){
                viewController.items = nil;
                [SharedAction showErrorWithStatus:status witViewController:viewController];
            }else{
                viewController.items = nil;
                [SharedAction showErrorDataError];
            }
        }else{
            viewController.items = nil;
            [SharedAction showErrorNoData];
            NSLog(@"%@",error);
        }
        viewController.orderType = RobOrderType;
        [viewController.tableview reloadData];
    }];
}

/*
 加载我的团购
 */
-(void)loadGroupOrderInViewController:(MyOrderViewController *)viewController{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *page = @"1";
    NSString *urlString = [NSString stringWithFormat:MyGroupsURL,user.token,user.user_type,page];
    NSLog(@"%@",urlString);
    [SharedAction show];
    MyGroups *myGroups = [[MyGroups alloc] initFromURLWithString:urlString completion:^(MyGroups *object,JSONModelError *error){
        NSLog(@"%@",myGroups);
        if (!error) {
            NSInteger status = object.status;
            if (status==2) {
                MyGroupOrderInfo *info = object.info;
                NSArray *orders = info.order;
                viewController.items = orders;
                [SharedAction dismiss];
            }else if(status==840){
                viewController.items = nil;
                [SharedAction showErrorWithStatus:status witViewController:viewController];
            }else{
                viewController.items = nil;
                [SharedAction showErrorNoData];
            }
        }else{
            viewController.items = nil;
            [SharedAction showErrorDataError];
            NSLog(@"%@",error);
        }
        viewController.orderType = GroupOrderType;
        [viewController.tableview reloadData];
    }];
    //    MyGroups *myGroups
}

/*
 订单详情
 */
-(void)pushToDetailViewControllerWithItem:(TradeOrder *)item onViewController:(MyOrderViewController *)myOrderViewController{
    TradeOrderDetailViewController *viewController = [myOrderViewController.storyboard instantiateViewControllerWithIdentifier:@"TradeOrderDetailViewController"];
    [myOrderViewController.navigationController pushViewController:viewController animated:YES];
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;

    NSString *urlString = [NSString stringWithFormat:DetailTradeOrderURL,item.orderid,user.token,user.user_type,@"1"];
    NSLog(@"%@",urlString);
    OrderDetailData *robOrderData = [[OrderDetailData alloc] initFromURLWithString:urlString completion:^(OrderDetailData *object,JSONModelError *error){
        NSLog(@"%@",robOrderData);
        if (!error) {
            NSInteger status = object.status;
            if (status==2) {
                OrderDetailInfo *info = object.info;
                viewController.items = info.goods;
            }else if(status==840){
                viewController.items = nil;
                [SharedAction showErrorWithStatus:status witViewController:viewController];
            }else{
                viewController.items = nil;
                [SharedAction showErrorDataError];
            }
        }else{
            viewController.items = nil;
            [SharedAction showErrorNoData];
            NSLog(@"%@",error);
        }
        [viewController.tableview reloadData];
    }];
}

/*
 我的秒杀订单
 */
-(void)loadKillOrderInViewController:(MyOrderViewController *)viewController{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *page = @"1";
    NSString *urlString = [NSString stringWithFormat:KillOrderURL,user.token,user.user_type,page];
    NSLog(@"%@",urlString);
    [SharedAction show];
    [MySecond getModelFromURLWithString:urlString completion:^(MySecond *object,JSONModelError *error){
        if (!error) {
            NSInteger status = object.status;
            if (status==2) {
                viewController.items = object.info.order;
                [SharedAction dismiss];
            }else if(status==840){
                viewController.items = nil;
                [SharedAction showErrorWithStatus:status witViewController:viewController];
            }else{
                viewController.items = nil;
                [SharedAction showErrorDataError];
            }
        }else{
            viewController.items = nil;
            [SharedAction showErrorNoData];
            NSLog(@"%@",error);
        }
        viewController.orderType = KillOrderType;
        [viewController.tableview reloadData];
    }];
    
}


@end
