//
//  GroupService.h
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupsViewController.h"
#import "GroupDetailViewController.h"

@interface GroupService : NSObject
//加如购物车
-(void)addToGroupWithPassword:(NSString *)password andToken:(NSString *)token andUser_type:(NSInteger)user_type andGid:(NSString *)gid andNums:(NSString *)nums inTabBarController:(UITabBarController *)tabBarController withDoneObject:(doneWithObject)done;

-(NSString *)toDetailTime:(NSInteger)seconds;
//将要团购的物品
-(void)groupsGoodsfutureWithToken:(NSString*)token andUser_type:(NSInteger )user_type intabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
//历史团购
-(void)groupsGoodsHistoryWithToken:(NSString*)token andUser_type:(NSInteger )user_type withTabBarController:(UITabBarController *)tabBarController andPage:(NSString *)page withDone:(doneWithObject)done;
//加载广告
-(void)loadAdverPicFromUrl:(NSString *)url inViewController:(GroupsViewController *)viewController;
//跳转充值页面
-(void)presentCreatePayViewControllerOnViewController:(UIViewController *)viewController;
@end
