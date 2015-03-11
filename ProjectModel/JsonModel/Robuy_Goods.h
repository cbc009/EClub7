 //
 //  ddsss.h 
 //  auton //
 //  Created by MartinLi on 15-3-5. 
 //  Copyright (c) 2015年 Club. All rights reserved.
 //
 #import "JSONModel.h"

@protocol Robuy_Goods_arr_goods_info <NSObject>
@end

@interface Robuy_Goods_arr_goods_info : JSONModel
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *seller_name;
@property(nonatomic,assign)NSInteger end_seconds;
@property(nonatomic,strong)NSString *starttime;
@property(nonatomic,strong)NSString *endtime;
@property(nonatomic,strong)NSString *actual_nums;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *receive_place;
@property(nonatomic,assign)NSInteger start_seconds;
@property(nonatomic,strong)NSString *receive_address;
@property(nonatomic,strong)NSString *receive_from;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *bigpicture;
@property(nonatomic,strong)NSString *point;
@property(nonatomic,strong)NSString *goods_id;
@property(nonatomic,strong)NSString *provider_nums;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *seller_id;
@property(nonatomic,strong)NSString *robuy_time;
@property(nonatomic,strong)NSString *seller_picture;
@property(nonatomic,strong)NSString *seller_intro;
@end

@interface Robuy_Goods_info : JSONModel
@property(nonatomic,strong)NSArray<Robuy_Goods_arr_goods_info> *arr_goods;
@end

@interface Robuy_Goods : JSONModel 
@property(nonatomic,strong)Robuy_Goods_info<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error; 
@end