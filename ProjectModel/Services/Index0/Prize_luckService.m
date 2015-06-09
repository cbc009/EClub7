//
//  Prize_luckService.m
//  Club
//
//  Created by MartinLi on 15/5/21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "Prize_luckService.h"
#import "PrizeLuckiesModel.h"
#import "prize_Lucky_Reoly_model.h"
#import "JSONModelLib.h"
#import "SVProgressHUD.h"
@implementation Prize_luckService
-(void)prizePrizeLuckiesWithToken:(NSString*)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController*)tabBarController WithDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString =[NSString stringWithFormat:Prize_Prize_Luckies_URL,token,user_type];
    [PrizeLuckiesModel getModelFromURLWithString:urlString completion:^(PrizeLuckiesModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)prizePrizeLuckiesReplyWithprize_id:(NSInteger )prize_id andToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController*)tabBarController WithDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Prize_Prize_Luckies_Reply_URL,prize_id,token,user_type];
    [prize_Lucky_Reoly_model getModelFromURLWithString:urlString completion:^(prize_Lucky_Reoly_model *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];

}
@end
