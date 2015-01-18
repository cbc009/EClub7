//
//  AccountService.h
//  Club
//
//  Created by MartinLi on 15-1-7.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountService : NSObject
-(void)base_accountWithToken:(NSString *)token andUserType:(NSInteger)userType inTabBarController:(UITabBarController *)tabBarController andPage:(NSInteger)page withDone:(doneWithObject)done;
@end
