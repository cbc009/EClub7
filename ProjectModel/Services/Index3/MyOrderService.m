//
//  MyOrderService.m
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "MyOrderService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "RobOrderData.h"
#import "JSONModelLib.h"
#import "OrderDetailData.h"
#import "MyGroups.h"
#import "MySecond.h"
#import "SharedAction.h"
#import "Status.h"
@implementation MyOrderService


-(void)loadOrderWithPage:(NSString *)pageString andToken:(NSString *)token andUser_type:(NSInteger)user_type andSelectedSegmentIndex:(NSInteger)selectedSegmentIndex inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    if (selectedSegmentIndex==0) {
        NSString *urlString = [NSString stringWithFormat:TradeOrderURL,token,user_type,pageString];
        [TradeOrderData getModelFromURLWithString:urlString completion:^(TradeOrderData *object,JSONModelError *error){
            [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object.info inTabBarController:tabBarController withDone:done];
        }];
    }else if(selectedSegmentIndex==1) {
        NSString *urlString = [NSString stringWithFormat:Robuy_Myorder_URL,token,user_type,pageString];
        [RobOrderData getModelFromURLWithString:urlString completion:^(RobOrderData *object,JSONModelError *error){
             [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object.info inTabBarController:tabBarController withDone:done];
        }];
    }else if(selectedSegmentIndex==2){
        NSString *urlString = [NSString stringWithFormat:MyGroupsURL,token,user_type,pageString];
        [MyGroups getModelFromURLWithString:urlString completion:^(MyGroups *object,JSONModelError *error){
             [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object.info inTabBarController:tabBarController withDone:done];
        }];
    }else  if(selectedSegmentIndex==3){
        NSString *urlString = [NSString stringWithFormat:KillOrderURL,token,user_type,pageString];
        [SharedAction show];
        [MySecond getModelFromURLWithString:urlString completion:^(MySecond *object,JSONModelError *error){
            [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object.info inTabBarController:tabBarController withDone:done];
        }];
    }
}

/*
 订单详情
 */
-(void)goodsOrderDetailWithToken:(NSString *)token andUser_type:(NSInteger )user_type andTabViewController:(UITabBarController *)tabbarController andOrderid:(NSString *)orderid witdone:(doneWithObject)done
{
     NSString *urlString = [NSString stringWithFormat:Goods_Order_Detail_URL,orderid,token,user_type];
    [OrderDetailData getModelFromURLWithString:urlString completion:^(OrderDetailData *object,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object.info inTabBarController:tabbarController withDone:done];
    }];
}
/*
 退货
 */
-(void)goodsOrderReturnwithToken:(NSString *)token andUser_type:(NSInteger )user_type andOrderid:(NSString *)orderid inTabbarViewController:(UITabBarController *)tabbarController withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:Goods_Order_Return_URL,orderid,token,user_type];
    [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabbarController withDone:done];
        
        
    }];

}

@end
