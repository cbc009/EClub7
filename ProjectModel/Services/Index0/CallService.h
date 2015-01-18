//
//  CallService.h
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallPhoneViewController.h"
@interface CallService : NSObject
-(void)CallPhoneWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPhone:(NSString *)phone intabBarController:(UITabBarController *)tabBarCOntroller withdone:(doneWithObject)done;

-(void)SiginWithToken:(NSString *)token andUser_Type:(NSInteger )user_type intabBarController:(UITabBarController *)tabBarCOntroller withdone:(doneWithObject)done;

@end
