//
//  BalanceData.h
//  Club
//
//  Created by MartinLi on 14-12-8.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BalanceModel.h"
@interface BalanceData : NSObject
@property(nonatomic,strong)BalanceIfo *balanceInfo;

+(id)sharedInstance;
@end
