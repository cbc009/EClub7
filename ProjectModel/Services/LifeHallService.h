//
//  LifeHallService.h
//  Club
//
//  Created by MartinLi on 15-1-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LifeHallService : NSObject
-(void)lifehalllifehalllistWithAgent_id:(NSInteger )agent_id andTabbarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)presentLifeHallDetailwithToken:(NSString *)token andUser_type:(NSInteger )uesr_type andLifeHall_id:(NSString*)lifehall_id inViewControllerOnViewController:(UIViewController *)viewController;

@end
