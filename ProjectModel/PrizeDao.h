//
//  PrizeDao.h
//  Club
//
//  Created by dongway on 14-8-18.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrizeModel.h"
@interface PrizeDao : NSObject
-(PrizeModel *)takeLotteryWithUser_type:(NSInteger )user_type andToken:(NSString *)token;
@end
