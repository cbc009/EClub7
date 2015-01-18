//
//  KillService.m
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "KillService.h"
#import "JSONModelLib.h"
#import "KillHistorModel.h"

#import "Kill_CountDown.h"
#import "Status.h"
#import "SVProgressHUD.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "NSString+MT.h"
#import "KIllSuccess.h"
@implementation KillService


-(void)kill_Goods_historyWithToken:(NSString *)token andUser_type:(NSInteger)user_type intabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:Kill_Goods_history_URL,token,user_type];
    [SVProgressHUD showWithStatus:@"正在加载历史秒杀商品"];
    [KillHistorModel getModelFromURLWithString:urlString completion:^(KillHistorModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)goods_futureWithToken:(NSString *)token andUser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:Kill_Goods_future,token,user_type];
    [SVProgressHUD showWithStatus:@"正在加载秒杀商品"];
    [Kills getModelFromURLWithString:urlString completion:^(Kills *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)kill_CountDownWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid intabBarController:(UITabBarController *)tabBarController withObject:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Kill_CountDown_URL,token,user_type,gid];
    [Kill_CountDown getModelFromURLWithString:urlString completion:^(Kill_CountDown *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)kill_Second_MemberWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Kill_Second_Member_URL,token,user_type,gid];
    [KIllSuccess getModelFromURLWithString:urlString completion:^(KIllSuccess *model,JSONModelError *error){
        NSLog(@"%@",urlString);
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];



}
//秒杀
-(void)killInViewController:(KillDetailViewController *)viewController{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *gid = viewController.good.gid;
    NSString *urlString = [NSString stringWithFormat:KillActionURL,user.token,user.user_type,gid];
    Status *status = [[Status alloc] initFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
        NSLog(@"%@",status);
        if (model.status==2) {
            user.amount = user.amount-[viewController.good.discount floatValue];
            NSString *message =[NSString stringWithFormat:@"恭喜你在E小区免费抢到%@赶快去告诉朋友吧",viewController.good.name];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"秒杀信息" message:message delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"去告诉朋友", nil];
            alertView.tag=1;
            [alertView show];
            viewController.buyButton.backgroundColor = [UIColor grayColor];
        }
        [SharedAction showErrorWithStatus:model.status andError:model.error witViewController:viewController];
    }];
}
@end
