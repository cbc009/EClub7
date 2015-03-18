//
//  AddMoreRobedRecordService.m
//  Club
//
//  Created by MartinLi on 14-11-16.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "AddMoreRobedRecordService.h"
#import "Member_History.h"
#import "Rob_goods_history.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "MJRefresh.h"
@implementation AddMoreRobedRecordService

//抢菜记录
-(void)robuy_memberWithGId:(NSString *)gid andPage:(NSString *)page inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString;
    if (gid==nil) {
     urlString  = [NSString stringWithFormat:Robuy_Robuy_Member_URL,gid,page];
    }
    else{
        urlString = [NSString stringWithFormat:Robuy_Robuy_Member_URL,gid,page];
    }
    [Member_History getModelFromURLWithString:urlString completion:^(Member_History *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
           }];
}

@end
