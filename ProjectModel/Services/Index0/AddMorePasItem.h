//
//  AddMorePasItem.h
//  Club
//
//  Created by MartinLi on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PastItemsTableViewController.h"
#import "RewardRecordsViewController.h"
@interface AddMorePasItem : NSObject
-(void)rob_goods_historyWithToken:(NSString *)token andUser_type:(NSInteger)user_type andPage:(NSString *)page withDone:(doneWithObjectAndStatus)done;
@end
