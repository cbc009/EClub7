//
//  PointOrder.h
//  Club
//
//  Created by MartinLi on 14-12-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol PointOrder <NSObject>
@end
@interface PointOrder : JSONModel
@property(nonatomic,strong)NSString *regtime;
@property(nonatomic,strong)NSString *point;
@property(nonatomic,strong)NSString *demo;
@end

@interface PointOrderInfo : JSONModel
@property(nonatomic,strong)NSArray<PointOrder> *order;
@end

@interface PointOrderData : JSONModel
@property(nonatomic,strong) PointOrderInfo<Optional>* info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end


