//
//  AddMorePasItem.m
//  Club
//
//  Created by MartinLi on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "AddMorePasItem.h"
#import "Rob_goods_history.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "MJRefresh.h"
#import "RobedRecordsViewController.h"
@implementation AddMorePasItem

-(void)rob_goods_historyWithLifehallId:(NSString *)lifehall_Id andSellerId:(NSString *)seller_id andPage:(NSString *)page inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:Robuy_Goods_history_URL,lifehall_Id,seller_id,page];
    [Rob_goods_history getModelFromURLWithString:urlString completion:^(Rob_goods_history *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}

@end
