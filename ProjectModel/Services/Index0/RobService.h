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

@interface RobService : NSObject
-(void)setRobModelWithLifehallid:(NSInteger )lifehallid orGoodsid:(NSString *)goodsId inRootTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)robWithToken:(NSString *)token andUser_type:(NSInteger )user_type andRobModel:(RobModelInfo *)robModel inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)loadAdverPicWithPos:(NSInteger)pos inViewController:(RobViewController *)viewController;
//-(void)setItemInfosWithController:(RobViewController *)viewController andGoodModel:(RobModelInfo *)good;
-(void)sellerInfoWithAgentid:(NSString*)agent_id andSeller_type:(NSString *)seller_type andSellerid:(NSString *)seller_id inRootTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
