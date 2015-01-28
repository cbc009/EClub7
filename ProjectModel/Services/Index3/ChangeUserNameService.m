//
//  ChangeUserName.m
//  Club
//
//  Created by MartinLi on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ChangeUserNameService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "UserDefaults.h"
#import "Status.h"
#import "JSONModelLib.h"

#import "SVProgressHUD.h"

#import "SharedAction.h"
@implementation ChangeUserNameService

-(void)changeUserNameService:(NSString *)nicname withToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withdone:(doneWithObject)done
{
    if (nicname.length<1) {
        [SVProgressHUD showErrorWithStatus:@"输入昵称不能为空"];
    }else {
        NSString *user_type1 =  [NSString stringWithFormat: @"%ld",(long)user_type];
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:token,user_type1,nicname,nil] forKeys:[NSArray arrayWithObjects:@"token",@"user_type",@"nickname", nil]];
        NSString *urlString = ChangeUserName;
        [JSONHTTPClient postJSONFromURLWithString:urlString params:dict completion:^(id object, JSONModelError *error) {
        NSNumber *status = object[@"status"];
            NSInteger sta = [status integerValue];
        NSString *error1 = object[@"error"];
        [SharedAction commonActionWithUrl:urlString andStatus:sta andError:error1 andJSONModelError:error andObject:object inTabBarController:tabBarController withDone:done];
        }];
    }
}


@end
