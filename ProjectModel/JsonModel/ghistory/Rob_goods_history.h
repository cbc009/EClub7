//
//  Mhistory.h
//  Club
//
//  Created by MartinLi on 14-8-30.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol PastItem <NSObject>
@end

@interface PastItem : JSONModel
@property(nonatomic,strong)NSString *goods_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *provider_nums;
@property(nonatomic,strong)NSString *bigpicture;
@property(nonatomic,strong)NSString *actual_nums;
@property(nonatomic,strong)NSString *starttime;
@property(nonatomic,strong)NSString *seller_name;
@property(nonatomic,strong)NSString *endtime;
@property(nonatomic,strong)NSString *seller_id;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString <Optional>*picture;
@property(nonatomic,strong)NSString *point;
@property(nonatomic,strong)NSString *receive_address;
@end

@interface Rob_goods_history_info : JSONModel
@property(nonatomic,strong)NSArray<PastItem> *arr_goods;
@end

@interface Rob_goods_history : JSONModel
@property(nonatomic,strong)Rob_goods_history_info<Optional> *info;
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@end
