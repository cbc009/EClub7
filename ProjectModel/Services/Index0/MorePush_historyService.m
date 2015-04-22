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


-(void)loadPush_historyWithAgentID:(NSInteger)agent_id andPage:(NSString *)page inTabBarcontroller:(UITabBarController *)tabBarController withdon:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Push_History,agent_id,page];
   
    [Push_history getModelFromURLWithString:urlString completion:^(Push_history *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
    
}

@end
