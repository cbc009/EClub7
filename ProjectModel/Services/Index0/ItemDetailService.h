//
//  ItemDetailService.h
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemDetailViewController.h"
@interface ItemDetailService : NSObject


-(void)presentPurchaseCarViewControllerWithToken:(NSString*)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid andNums:(NSString *)nums inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;

-(void)addToPurchaseCarWithGid:(NSString *)gid andNum:(NSString *)num inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
//-(void)presentGoodDetaiViewControllerWithGid:(NSString *)gid AndName:(NSString *)name OnViewController:(UIViewController *)viewController;
@end
