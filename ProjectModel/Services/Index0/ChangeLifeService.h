//
//  ChangeLifeService.h
//  Club
//
//  Created by MartinLi on 15-3-11.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootTabBarViewController.h"
@interface ChangeLifeService : NSObject
//修改生活馆
-(void)publiclifehallWithagentid:(NSString *)agent_id andLifehallId:(NSString *)lifehall_id inTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done;
@end
