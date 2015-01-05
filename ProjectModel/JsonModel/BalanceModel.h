//
//  BalanceModel.h
//  Club
//
//  Created by MartinLi on 14-12-8.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@interface BalanceIfo : JSONModel
@property (nonatomic ,strong)NSString *iccard;
@property (nonatomic ,strong)NSString *amount;
@property (nonatomic ,assign)NSInteger phone_minute;
@property (nonatomic ,assign)CGFloat amount_red;
@property (nonatomic ,strong)NSString *point;
@end

@interface BalanceModel : JSONModel
@property (nonatomic ,strong) NSString *error;
@property (nonatomic ,assign) NSInteger status;
@property (nonatomic ,strong) BalanceIfo <Optional>*info;
@end



