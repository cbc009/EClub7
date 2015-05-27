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
@property(nonatomic,strong)NSString <Optional>*orderid;
@property(nonatomic,strong)NSString <Optional>*gid;
@property(nonatomic,strong)NSString <Optional>*name;
@property(nonatomic,strong)NSString <Optional>*regtime;
@property(nonatomic,strong)NSString <Optional>*status;
@property(nonatomic,strong)NSString <Optional>*picture;
@property(nonatomic,strong)NSString <Optional>*discount;
@property(nonatomic,strong)NSString <Optional>*unit;
@property(nonatomic,strong)NSString <Optional>*point;
@property(nonatomic,strong)NSString <Optional>*receive_address;
@end

@interface RobOrderInfo : JSONModel
@property(nonatomic,strong)NSArray<RobOrder,Optional>* order;
@end

@interface RobOrderData : JSONModel
@property(nonatomic,strong)RobOrderInfo<Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end
