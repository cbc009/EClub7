//
//  CallHistoryService.h
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallPhoneViewController.h"
@interface CallHistoryService : NSObject
//获取打电话的历史信息
-(void)call_historyWithToken:(NSString *)token andUser_type:(NSInteger )user_type andPageString:(NSString *)pageString inTabBarController:(UITabBarController *)tabBarController withDoneObject:(doneWithObject)done;
//加载广告
-(void)loadAdverPicFromUrl:(NSString *)urlString inViewController:(CallPhoneViewController *)viewController;
@end
