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

-(void)startCountDownActionWithSeconds:(NSInteger)seconds;

@end

@interface KillService : NSObject
@property(nonatomic,weak)id<KillServiceDelegate> delegate;
-(void)kill_CountDownWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid intabBarController:(UITabBarController *)tabBarController withObject:(doneWithObject)done;
-(void)killWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)kill_Goods_historyWithToken:(NSString *)token andUser_type:(NSInteger)user_type intabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)goods_futureWithToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)kill_Second_MemberWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
