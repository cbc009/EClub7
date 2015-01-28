//
//  PeopleDetailService.m
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PeopleDetailService.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "LiveModel.h"
#import "PeopleDetailViewController.h"
@implementation PeopleDetailService
-(void)lifecircleMyinfoWithMid:(NSInteger)mid andToken:(NSString *)token andUser_type:(NSInteger)user_type andPageString:(NSString*)pageString withTabBarController:(UITabBarController *)tabBarController witDoneObject:(doneWithObject)done;
{
    NSString *urlString = [NSString stringWithFormat:Lifecircle_Myinfo_info_URL,mid,token,user_type,pageString];
    [LiveModel getModelFromURLWithString:urlString completion:^(LiveModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}

@end
