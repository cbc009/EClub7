//
//  GroupService.h
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupsViewController.h"
#import "GroupDetailViewController.h"

@interface GroupService : NSObject

-(void)addToGroupWithPassword:(NSString *)password andToken:(NSString *)token andUser_type:(NSInteger)user_type andGid:(NSString *)gid andNums:(NSString *)nums inTabBarController:(UITabBarController *)tabBarController withDoneObject:(doneWithObject)done;
-(NSString *)toDetailTime:(NSInteger)seconds;
-(void)groupsGoodsfutureWithToken:(NSString*)token andUser_type:(NSInteger )user_type intabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)groupsGoodsHistoryWithToken:(NSString*)token andUser_type:(NSInteger )user_type withTabBarController:(UITabBarController *)tabBarController andPage:(NSString *)page withDone:(doneWithObject)done;
-(void)loadAdverPicFromUrl:(NSString *)url inViewController:(GroupsViewController *)viewController;
-(void)presentCreatePayViewControllerOnViewController:(UIViewController *)viewController;
@end
