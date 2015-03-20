//
//  RobService.h
//  Club
//
//  Created by dongway on 14-8-19.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RobViewController.h"
#import "RobedRecordsViewController.h"
#import "PastItemsTableViewController.h"
#import "Robuy_Goods.h"
@interface RobService : NSObject
//加载抢购首页信息
-(void)setRobModelWithLifehallid:(NSString *)lifehallid orDetail:(NSString *)detail inRootTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
//抢购
-(void)robWithToken:(NSString *)token andLifehallId:(NSString *)lifehall_id andUser_type:(NSInteger )user_type andRobModel:(Robuy_Goods_arr_goods_info *)robModel inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
//加载广告
-(void)loadAdverPicWithPos:(NSInteger)pos inViewController:(RobViewController *)viewController;
//-(void)setItemInfosWithController:(RobViewController *)viewController andGoodModel:(RobModelInfo *)good;
//获取商家信息
-(void)sellerInfoWithAgentid:(NSString*)agent_id andSeller_type:(NSString *)seller_type andSellerid:(NSString *)seller_id inRootTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
