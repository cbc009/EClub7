//
//  MorePush_historyService.h
//  Club
//
//  Created by MartinLi on 14-11-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MorePush_history.h"
@interface MorePush_historyService : NSObject
//加载历史推送消息
-(void)loadPush_historyWithToken:(NSString *)token andUser_type:(NSInteger )user_type andPage:(NSString *)page inTabBarcontroller:(UITabBarController *)tabBarController withdon:(doneWithObject)done;
@end
