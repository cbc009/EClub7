//
//  KillService.h
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KillListViewController.h"
#import "KillDetailViewController.h"
#import "KillHistoryViewController.h"
@protocol KillServiceDelegate <NSObject>

-(void)startCountDownActionWithSeconds:(NSInteger)seconds;

@end

@interface KillService : NSObject
@property(nonatomic,weak)id<KillServiceDelegate> delegate;
-(void)kill_CountDownWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid withObject:(doneWithObject)done;
-(void)killInViewController:(KillDetailViewController *)viewController;
-(void)kill_Goods_historyWithToken:(NSString *)token andUser_type:(NSInteger)user_type withDone:(doneWithObjectAndStatus)done;
-(void)goods_futureWithToken:(NSString *)token andUser_type:(NSInteger)user_type withDone:(doneWithObjectAndStatus)done;
@end
