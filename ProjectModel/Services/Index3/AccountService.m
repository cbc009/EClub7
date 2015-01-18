//
//  AccountService.m
//  Club
//
//  Created by MartinLi on 15-1-7.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "AccountService.h"
#import "Amount.h"
#import <JSONModelLib.h>
@implementation AccountService

-(void)base_accountWithToken:(NSString *)token andUserType:(NSInteger)userType inTabBarController:(UITabBarController *)tabBarController andPage:(NSInteger)page withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:AmountURL,token,userType,[NSString stringWithFormat:@"%ld",(long)page]];
    [Amount getModelFromURLWithString:urlString completion:^(Amount *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}

@end
