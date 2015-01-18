//
//  PeopleDetailService.h
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeopleDetailViewController.h"
@interface PeopleDetailService : NSObject
-(void)LifecircleMyinfoWithMid:(NSInteger)mid andToken:(NSString *)token andUser_type:(NSInteger)user_type withTabBarController:(UITabBarController *)tabBarController witDoneObject:(doneWithObject)done;
-(void)countSizeWithData:(NSArray *)data inViewController:(PeopleDetailViewController *)viewController;
@end
