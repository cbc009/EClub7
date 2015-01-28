//
//  FeedbackService.h
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedbackViewController.h"
@interface FeedbackService : NSObject

-(void)submitWithContent:(NSString *)content withToken:(NSString *)token andUser_type:(NSInteger )user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)baseMyadviceWithToken:(NSString *)token andUser_Type:(NSInteger)user_typ intabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done;
@end
