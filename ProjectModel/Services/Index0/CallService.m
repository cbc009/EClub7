//
//  CallService.m
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "CallService.h"
#import "JSONModelLib.h"
#import "CallPhone.h"
#import "BalanceModel.h"
#import "SiginModel.h"
#import "SharedData.h"
#import "Login.h"
#import "BalanceData.h"
#import "SVProgressHUD.h"
#import "Status.h"
@implementation CallService
-(void)CallPhoneWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPhone:(NSString *)phone OnViewCOntroller:(CallPhoneViewController *)viewCOntroller
{
    NSString *urlString = [NSString stringWithFormat:Call,token,user_type,phone];
    [SVProgressHUD show];
    [CallPhone getModelFromURLWithString:urlString completion:^(CallPhone *object,JSONModelError *err){
        if (object.status==2) {
            [SVProgressHUD showSuccessWithStatus:object.error];
        } else{
            [SVProgressHUD showErrorWithStatus:object.error];
        }
    }];
 
}
-(void)SiginWithToken:(NSString *)token andUser_Type:(NSInteger )user_type OnViewController:(CallPhoneViewController *)viewController
{
    NSString *urlString = [NSString stringWithFormat:Sigin,token,user_type];
    NSLog(@"%@",urlString);
    [SVProgressHUD show];
    [SiginModel getModelFromURLWithString:urlString completion:^(SiginModel *object,JSONModelError *err){
    if (object.status==2) {
            viewController.minutes.text =[NSString stringWithFormat:@"%ld分钟",(long)object.info.minutes];
        }
        [SVProgressHUD showSuccessWithStatus:object.error];
    }];
}

@end
