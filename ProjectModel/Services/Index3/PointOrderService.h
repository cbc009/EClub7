//
//  PointOrderService.h
//  Club
//
//  Created by MartinLi on 14-12-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PointOrdViewController.h"
@interface PointOrderService : NSObject
-(void)loadTradeOrderWithToken:(NSString *)token anduser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withdone:(doneWithObject)done;
@end
