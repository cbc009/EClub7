//
//  BalanceData.m
//  Club
//
//  Created by MartinLi on 14-12-8.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "BalanceData.h"

@implementation BalanceData
+(BalanceData *)sharedInstance{
    static BalanceData *sharedUser = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedUser = [[BalanceData alloc] init];
    });
    return sharedUser;
}


@end
