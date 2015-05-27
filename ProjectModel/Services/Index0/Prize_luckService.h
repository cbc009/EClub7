//
//  Prize_luckService.h
//  Club
//
//  Created by MartinLi on 15/5/21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prize_luckService : NSObject
-(void)prizePrizeLuckiesWithToken:(NSString*)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController*)tabBarController WithDone:(doneWithObject)done;
-(void)prizePrizeLuckiesReplyWithprize_id:(NSInteger )prize_id andToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController*)tabBarController WithDone:(doneWithObject)done;
@end
