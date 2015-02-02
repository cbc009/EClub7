//
//  Delivery.h
//  Club
//
//  Created by Gao Huang on 14-11-10.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@interface DeliveryInfo : JSONModel
@property(nonatomic,strong)NSArray *sendtime;
@property(nonatomic,strong)NSString *delivery_limit;
@property(nonatomic,assign)NSInteger shipping_fee;
@property(nonatomic,strong)NSString *delivery_scope;
@end

@interface Delivery : JSONModel
@property(nonatomic,strong)DeliveryInfo <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end
