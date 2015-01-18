//
//  RewardRecordService.m
//  Club
//
//  Created by MartinLi on 15-1-16.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RewardRecordService.h"
#import "RewardRcord.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "MJRefresh.h"
@implementation RewardRecordService
-(void)prizePrizeLuckyWithToken:(NSString *)token andUser_type:(NSInteger)user_type andPageString:(NSString *)pageString andTabBarController:(UITabBarController *)tabBarController witDone:(doneWithObject)done
{
    [SVProgressHUD show];
    NSString *urlString = [NSString stringWithFormat:Prize_Myluckies_URL,token,user_type,pageString];
    [RewardRcord getModelFromURLWithString:urlString completion:^(RewardRcord *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
@end
