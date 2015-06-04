//
//  Index0Service.h
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MartinLiPageScrollView.h"
#import "Index0_3ViewController.h"
#import "ChangeAgentViewController.h"
@interface Index0Service : NSObject
//加载用户信息  loginStatus 为记住的登录状态
-(void)loadUserDefaultsInViewController:(Index0_3ViewController *)viewController witLoginStatus:(NSString *)loginStatus andLongitude:(NSString *)longitude andLatitude:(NSString *)latitude;
//加载广告
-(void)loadAdverPicWithPos:(NSInteger)pos andAgentID:(NSInteger)agent_id inViewController:(UIViewController *)viewController;
//-(void)GetBalanceWithToken:(NSString *)token andUser_type:(NSInteger )user_type onViewController:(Index0_3ViewController *)viewController;
-(void)loginIndexWithAgentId:(NSInteger)agent_id andLifeHallId:(NSInteger)lifeHall_id inViewCOntroller:(Index0_3ViewController*)viewController;
-(NSArray *)namesFromPictures:(NSArray *)pictures;
-(NSArray *)titlesFromPictures:(NSArray *)pictures;
-(NSArray *)urlsFromPictures:(NSArray *)pictures;
-(void)presentChangeAgentViewControllerIn:(Index0_3ViewController*)viewController;
-(void)prensentSerchViewControllerIn:(Index0_3ViewController*)viewController;
-(void)presentMorePush_historyIn:(Index0_3ViewController*)viewController;
@end
