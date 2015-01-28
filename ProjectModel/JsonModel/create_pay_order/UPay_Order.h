//
//  UPay_Order.h
//  Club
//
//  Created by MartinLi on 15-1-22.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@interface UPay_Order_info : JSONModel
@property(nonatomic,strong) NSString *tn;
@end


@interface UPay_Order : JSONModel
@property(nonatomic,strong) NSString *error;
@property(nonatomic,assign)  NSInteger status;
@property(nonatomic,strong) UPay_Order_info *info;
@end
