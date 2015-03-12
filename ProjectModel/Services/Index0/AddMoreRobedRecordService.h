//
//  AddMoreRobedRecordService.h
//  Club
//
//  Created by MartinLi on 14-11-16.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RobedRecordsViewController.h"
@interface AddMoreRobedRecordService : NSObject
//加载更多的抢购记录
-(void)robuy_memberWithGId:(NSString *)gid andPage:(NSString *)page inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;

@end
