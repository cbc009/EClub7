//
//  AddMorePasItem.m
//  Club
//
//  Created by MartinLi on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "AddMorePasItem.h"
#import "Rob_goods_history.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "MJRefresh.h"
#import "RobedRecordsTableViewController.h"
@implementation AddMorePasItem

-(void)rob_goods_historyWithToken:(NSString *)token andUser_type:(NSInteger)user_type andPage:(NSString *)page withDone:(doneWithObjectAndStatus)done{
    NSString *urlString = [NSString stringWithFormat:Rob_goods_history_URL,token,user_type,page];
    [Rob_goods_history getModelFromURLWithString:urlString completion:^(Rob_goods_history *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info withDoneAndStatus:done];
    }];
}

@end
