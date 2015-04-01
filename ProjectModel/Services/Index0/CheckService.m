//
//  CheckService.m
//  Club
//
//  Created by MartinLi on 15-3-30.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "CheckService.h"
#import "Status.h"
#import "JSONModelLib.h"
#import "SVProgressHUD.h"
@implementation CheckService
-(void)sellerOrderWithGoodsType:(NSString *)goods_type andGoodsId:(NSString *)goods_id andGoodsNums:(NSString *)goods_nums andLifehall_id:(NSString *)lifehall_id andPay_mode:(NSString *)pay_mode andPaypassword:(NSString *)paypassword andReceive_type:(NSString *)receive_type andMessage:(NSString *)message andAddress:(NSString *)address andMobole:(NSString*)mobile andSend_time:(NSString *)send_time andToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *user_type1 = [NSString stringWithFormat:@"%ld",(long)user_type];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:goods_type,goods_id,goods_nums,lifehall_id,pay_mode,paypassword,receive_type,message, address,mobile,send_time,token,user_type1,nil] forKeys:[NSArray arrayWithObjects:@"goods_type",@"goods_id",@"goods_nums", @"lifehall_id",@"pay_mode",@"paypassword",@"receive_type",@"message",@"address",@"mobile",@"send_time",@"token",@"user_type",nil]];
    NSString *urlString = Seller_Seller_Order_URL;
    NSLog(@"%@",dict);
    [JSONHTTPClient postJSONFromURLWithString:urlString params:dict completion:^(id object, JSONModelError *error) {
        NSString *error1 = (NSString *)[object objectForKey:@"error"];
        NSNumber *sta = (NSNumber*)[object objectForKey:@"status"];
        NSInteger status = [sta integerValue];
        [SharedAction commonActionWithUrl:urlString andStatus:status andError:error1 andJSONModelError:error andObject:object inTabBarController:tabBarController withDone:done];
    }];
}
@end
