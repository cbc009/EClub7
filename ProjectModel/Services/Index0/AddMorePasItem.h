//
//  AddMorePasItem.h
//  Club
//
//  Created by MartinLi on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PastItemsTableViewController.h"
#import "RewardRecordsViewController.h"
@interface AddMorePasItem : NSObject
//加载抢购历史
-(void)rob_goods_historyWithLifehallId:(NSString *)lifehall_Id andSellerId:(NSString *)seller_id andPage:(NSString *)page inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
