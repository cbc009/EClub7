//
//  RobOrder.h
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol RobOrder <NSObject>
@end
@interface RobOrder : JSONModel
@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,strong)NSString *goods_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *regtime;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *point;
@property(nonatomic,strong)NSString *receive_address;
@end

@interface RobOrderInfo : JSONModel
@property(nonatomic,strong)NSArray<RobOrder,Optional>* arr_order;
@end

@interface RobOrderData : JSONModel
@property(nonatomic,strong)RobOrderInfo<Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end
