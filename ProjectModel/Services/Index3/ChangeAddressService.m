//
//  ChangeAddressService.m
//  Club
//
//  Created by MartinLi on 14-11-14.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ChangeAddressService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "Status.h"
#import "UserDefaults.h"
#import "JSONModelLib.h"
#import "SharedAction.h"
#import "SharedData.h"
#import "Member_Login.h"
@implementation ChangeAddressService
-(void)changeAddressService:(NSString *)address withToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withdone:(doneWithObject)done
{
    if (address.length<1) {
        [SharedAction showErrorInput];
    }else {
        NSString *user_type1 =  [NSString stringWithFormat: @"%ld",(long)user_type];;
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:token,user_type1,address,nil] forKeys:[NSArray arrayWithObjects:@"token",@"user_type",@"address", nil]];
        NSString *urlString = ChangeAddress;
        [JSONHTTPClient postJSONFromURLWithString:urlString params:dict completion:^(id object, JSONModelError *error) {
            NSNumber *stat = (NSNumber *)[object objectForKey:@"status"];
            NSString *error1 = (NSString *)[object objectForKey:@"error"];
            NSInteger status = [stat integerValue];
            [SharedAction commonActionWithUrl:urlString andStatus:status andError:error1 andJSONModelError:error andObject:object inTabBarController:tabBarController withDone:done];
        }];
    }
    
}
@end
