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
-(void)ChangeAddressService:(NSString *)address onChangeAdressViewController:(ChangeAdressViewController *)ChangeAdressViewController
{
    UserDefaults *userDefaults = [[UserDefaults alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    if (address.length<1) {
        [SharedAction showErrorInput];
    }else {
        NSString *user_type =  [NSString stringWithFormat: @"%ld",(long)user.user_type];;
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:user.token,user_type,address,nil] forKeys:[NSArray arrayWithObjects:@"token",@"user_type",@"address", nil]];
        NSString *urlString = ChangeAddress;
        [JSONHTTPClient postJSONFromURLWithString:urlString params:dict completion:^(id object, JSONModelError *error) {
            NSNumber *stat = (NSNumber *)[object objectForKey:@"status"];
            NSString *error1 = (NSString *)[object objectForKey:@"error"];
            NSInteger status = [stat integerValue];
            if (status==2) {
                [SharedAction showErrorWithStatus:status andError:error1 witViewController:ChangeAdressViewController];
                user.address = address;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData"object:nil];
                [userDefaults ChangeAddressgo:address onChangeAddress:ChangeAdressViewController];
                [ChangeAdressViewController.navigationController popViewControllerAnimated:YES];
            }
            else {
               [SharedAction showErrorWithStatus:status andError:error1 witViewController:ChangeAdressViewController];
            }
        }];
    }
    
}
@end
