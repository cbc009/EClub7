//
//  CheckService.h
//  Club
//
//  Created by MartinLi on 15-3-30.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckService : NSObject
-(void)sellerOrderWithGoodsType:(NSString *)goods_type andGoodsId:(NSString *)goods_id andGoodsNums:(NSString *)goods_nums andLifehall_id:(NSString *)lifehall_id andPay_mode:(NSString *)pay_mode andPaypassword:(NSString *)paypassword andReceive_type:(NSString *)receive_type andMessage:(NSString *)message andAddress:(NSString *)address andMobole:(NSString*)mobile andSend_time:(NSString *)send_time andToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
