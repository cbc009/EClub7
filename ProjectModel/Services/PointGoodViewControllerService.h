//
//  PointGoodViewControllerService.h
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PointGoodViewController.h"
@interface PointGoodViewControllerService : NSObject
//兑换积分兑换的商品
-(void)addOderINPointGoodWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGId:(NSInteger )gid andNus:(NSString *)nums andPassword:(NSString *)passwd inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
