//
//  KillService.h
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KillListViewController.h"
#import "KillDetailViewController.h"
#import "KillHistoryViewController.h"
@protocol KillServiceDelegate <NSObject>
//开始倒计时
-(void)startCountDownActionWithSeconds:(NSInteger)seconds;

@end

@interface KillService : NSObject
@property(nonatomic,weak)id<KillServiceDelegate> delegate;
//获取秒杀倒计时
-(void)kill_CountDownWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid intabBarController:(UITabBarController *)tabBarController withObject:(doneWithObject)done;
//秒杀
-(void)killWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
//历史秒杀
-(void)kill_Goods_historyWithToken:(NSString *)token andUser_type:(NSInteger)user_type intabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
//将要开始秒杀
-(void)goods_futureWithToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
//秒杀到得人名单
-(void)kill_Second_MemberWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
