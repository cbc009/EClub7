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

-(void)robuy_memberWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGId:(NSString *)gid andPage:(NSString *)page inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;

@end
