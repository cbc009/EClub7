//
//  LifecircleService.h
//  Club
//
//  Created by MartinLi on 15-1-12.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LifeHallViewController.h"
@interface LifecircleService : NSObject
-(void)lifecircleWitkToken:(NSString *)token andUser_Type:(NSInteger )user_type withContent:(NSString *)content andImageArray:(NSArray *)imageArray withTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done;
-(void)LifecircleLifedeleteWithToken:(NSString *)token andUser_type:(NSInteger )user_type andXid:(NSString *)xid withDone:(doneWithObject)done;
-(void)LifecircleLifeCommentWithToken:(NSString *)token andUser_type:(NSInteger )user_type andContent:(NSString *)content andXid:(NSString *)xid withTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done;
@end
