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

-(void)ChangeUserNameService:(NSString *)nicname onChangeNameViewcontroller:(ChangeNameViewController *)ChangeNameViewController
{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    if (nicname.length<1) {
        [SVProgressHUD showErrorWithStatus:@"输入昵称不能为空"];
    }else {
        NSString *user_type =  [NSString stringWithFormat: @"%ld",(long)user.user_type];
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:user.token,user_type,nicname,nil] forKeys:[NSArray arrayWithObjects:@"token",@"user_type",@"nickname", nil]];
        NSString *urlString = ChangeUserName;
        [JSONHTTPClient postJSONFromURLWithString:urlString params:dict completion:^(id object, JSONModelError *error) {
            NSNumber *status = object[@"status"];
            NSString *error1 = object[@"error"];
            if ([status isEqual:[NSNumber numberWithInt:2]]) {
                user.nickname = nicname;
                [ChangeNameViewController.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            }else{
                [SharedAction showErrorWithStatus:[status integerValue] andError:error1 witViewController:ChangeNameViewController];
            }
          
        }];
    }
}


@end
