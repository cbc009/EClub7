//
//  SearchService.h
//  Club
//
//  Created by MartinLi on 14-12-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SerchViewController.h"
@interface SearchService : NSObject
//商品搜索
-(void)goodsSearchWithToken:(NSString *)token andUser_type:(NSInteger )user_type anName:(NSString *)name inTabBarController:(UITabBarController *)tabBarController withDoneObject:(doneWithObject)done;
//搜索的标签
-(void)searchLabelwithToken:(NSString *)token andUser_type:(NSInteger )user_type inTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done;
@end
