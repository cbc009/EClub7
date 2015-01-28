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
-(void)lifecircleMyinfoWithMid:(NSInteger)mid andToken:(NSString *)token andUser_type:(NSInteger)user_type andPageString:(NSString*)pageString withTabBarController:(UITabBarController *)tabBarController witDoneObject:(doneWithObject)done;
@end
