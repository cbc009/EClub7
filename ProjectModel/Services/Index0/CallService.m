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
#import "Member_Login.h"
#import "BalanceData.h"
#import "SVProgressHUD.h"
#import "Status.h"
@implementation CallService
-(void)callPhoneWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPhone:(NSString *)phone intabBarController:(UITabBarController *)tabBarCOntroller withdone:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Call,token,user_type,phone];
    [SVProgressHUD show];
    [CallPhone getModelFromURLWithString:urlString completion:^(CallPhone *object,JSONModelError *err){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:err andObject:object inTabBarController:tabBarCOntroller withDone:done];
    }];
}
-(void)siginWithToken:(NSString *)token andUser_Type:(NSInteger )user_type intabBarController:(UITabBarController *)tabBarCOntroller withdone:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Sigin,token,user_type];
    NSLog(@"%@",urlString);
    [SVProgressHUD show];
    [SiginModel getModelFromURLWithString:urlString completion:^(SiginModel *object,JSONModelError *err){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:err andObject:object.info inTabBarController:tabBarCOntroller withDone:done];
    }];
}
-(void)callPhoneTopupWithToken:(NSString *)token andUser_type:(NSInteger)user_type andMobile:(NSString *)mobile andMinutes:(NSString *)minutes inTabBarcontroller:(UITabBarController *)tabBarController withDone:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Call_Phone_Topup_URL,token,user_type,mobile,minutes];
    [SVProgressHUD show];
    [Status getModelFromURLWithString:urlString completion:^(Status *object,JSONModelError *err){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:err andObject:object inTabBarController:tabBarController withDone:done];
    }];



}
@end
