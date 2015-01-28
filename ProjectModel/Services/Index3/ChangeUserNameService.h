//
//  ChangeUserName.h
//  Club
//
//  Created by MartinLi on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeNameViewController.h"

@interface ChangeUserNameService : NSObject
-(void)changeUserNameService:(NSString *)nicname withToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withdone:(doneWithObject)done;

@end
