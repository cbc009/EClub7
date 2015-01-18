//
//  Index1Service.h
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Index1ViewController.h"
@interface Index1Service : NSObject

-(UIImageView *)previewByCurrentView:(UIImageView *)curView andArray:(NSArray *)views;
-(UIImageView *)nextViewByCurrentView:(UIImageView *)curView andArray:(NSArray *)views;

-(float)accelerateSpeedOfTimeMomentWithResultValue:(NSUInteger)resultValue andEndTimerTotal:(float)endTimerTotal inViews:(NSArray *)views whenCurrentView:(UIImageView *)currentView;
-(void)moveCurrentView:(UIImageView *)curView inArray:(NSArray *)views;

-(void)showAwardViewWithDatas:(NSArray *)datas andCurrentView:(UIImageView *)currentView andSerialid:(NSUInteger)serialid inController:(UIViewController *)viewController;

-(void)loadWebViewWithURLString:(NSString *)URLString andTitle:(NSString *)title onViewContrller:(UIViewController *)viewController;
-(void)presentRewardRecordViewControllerInViewController:(UIViewController *)viewController;
-(void)prize_IndexWithToken:(NSString *)token andUser_type:(NSInteger)user_type withTabBarController:(UITabBarController *)tabBarController withdone:(doneWithObject)done;
-(void)getPrizeLUckyWithToken:(NSString *)token andUser_Type:(NSInteger )user_type andTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
