//
//  CallService.h
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallPhoneViewController.h"
@interface CallService : NSObject
//打电话
-(void)callPhoneWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPhone:(NSString *)phone intabBarController:(UITabBarController *)tabBarCOntroller withdone:(doneWithObject)done;
//签到
-(void)siginWithToken:(NSString *)token andUser_Type:(NSInteger )user_type intabBarController:(UITabBarController *)tabBarCOntroller withdone:(doneWithObject)done;
//充值
-(void)callPhoneTopupWithToken:(NSString *)token andUser_type:(NSInteger)user_type andMobile:(NSString *)mobile andMinutes:(NSString *)minutes inTabBarcontroller:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
