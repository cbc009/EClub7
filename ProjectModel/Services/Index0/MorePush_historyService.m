//
//  MorePush_historyService.m
//  Club
//
//  Created by MartinLi on 14-11-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "MorePush_historyService.h"
#import "JSONModelLib.h"
#import "Push_history.h"
#import "SVProgressHUD.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "SharedAction.h"
#import "MJRefresh.h"
@implementation MorePush_historyService


-(void)loadPush_historyWithToken:(NSString *)token andUser_type:(NSInteger )user_type andPage:(NSString *)page InViewController:(MorePush_history *)viewController
{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *urlString = [NSString stringWithFormat:Push_History,user.token,user_type,page];
    [SVProgressHUD show];
    NSLog(@"%@",urlString);
    [Push_history getModelFromURLWithString:urlString completion:^(Push_history *model,JSONModelError *error){
        if (model.status == 2) {
            viewController.datas = model.info.push;
            [viewController.tableView reloadData];
            [viewController.tableView headerEndRefreshing];
            [SVProgressHUD dismiss];
        } else{
            [SVProgressHUD showErrorWithStatus:model.error];
        }
    }];
    
}
-(void)loadMorePush_historyWithToken:(NSString *)token andUser_type:(NSInteger )user_type andPage:(NSString *)page InViewController:(MorePush_history *)viewController
{
    NSString *urlString = [NSString stringWithFormat:Push_History,token,user_type,page];
    [SVProgressHUD show];
    [Push_history getModelFromURLWithString:urlString completion:^(Push_history *model,JSONModelError *error){
        if (model.status == 2) {
            [viewController.datas addObjectsFromArray:model.info.push];
            [SVProgressHUD dismiss];
            [viewController.tableView reloadData];
        } else{
            [SVProgressHUD showErrorWithStatus:@"没有更多的数据"];
            NSLog(@"%@",error);
        }
    }];
}
@end
