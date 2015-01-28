//
//  ChangeAddressService.h
//  Club
//
//  Created by MartinLi on 14-11-14.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeAdressViewController.h"

@interface ChangeAddressService : NSObject
-(void)changeAddressService:(NSString *)address withToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withdone:(doneWithObject)done;
@end
