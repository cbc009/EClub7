//
//  RewardRecordService.h
//  Club
//
//  Created by MartinLi on 15-1-16.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RewardRecordService : NSObject
-(void)prizePrizeLuckyWithToken:(NSString *)token andUser_type:(NSInteger)user_type andPageString:(NSString *)pageString andTabBarController:(UITabBarController *)tabBarController witDone:(doneWithObject)done;
@end
