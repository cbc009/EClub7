//
//  PointVIewControllerService.h
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PointViewController.h"
@interface PointVIewControllerService : NSObject
//跳到积分兑换页
-(void)presentPointGoodViewControllerWithDatas:(NSDictionary *)dic OnPointViewController:(PointViewController *)viewController;
//加载兑换商城
-(void)loadDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPage:(NSString *)page intabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;

@end
