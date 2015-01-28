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


-(void)loadPush_historyWithToken:(NSString *)token andUser_type:(NSInteger )user_type andPage:(NSString *)page inTabBarcontroller:(UITabBarController *)tabBarController withdon:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Push_History,token,user_type,page];
   
    [Push_history getModelFromURLWithString:urlString completion:^(Push_history *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
    
}

@end
