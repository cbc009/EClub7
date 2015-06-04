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
-(void)goodsSearchWithAgent_id:(NSInteger )agent_id anName:(NSString *)name inTabBarController:(UITabBarController *)tabBarController withDoneObject:(doneWithObject)done;
//搜索的标签
-(void)searchLabelwithAgent_id:(NSString *)agent_id inTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done;
@end
