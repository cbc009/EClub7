 //
 //  Seller_Seller_Goods.h 
 //  auton //
 //  Created by MartinLi on 15-3-5. 
 //  Copyright (c) 2015年 Club. All rights reserved.
 //
 #import "JSONModel.h"

@protocol Seller_Seller_Goods_info <NSObject>
@end
@protocol Seller_Seller_Goods_arr_goods_info <NSObject>
@end

@interface Seller_Seller_Goods_arr_goods_info : JSONModel
@property(nonatomic,strong)NSString *goods_name;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSArray <Optional>*send_time;
@property(nonatomic,strong)NSString *actual_nums;
@property(nonatomic,strong)NSString <Optional>*provider_nums;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *bigpicture;
@property(nonatomic,strong)NSString <Optional>*point;
@property(nonatomic,strong)NSString *goods_id;
@property(nonatomic,strong)NSString <Optional>*seller_id;
@property(nonatomic,strong)NSString <Optional>*seller_name;
@property(nonatomic,strong)NSString <Optional>*seller_picture;
@property(nonatomic,strong)NSString <Optional>*seller_intro;
@property(nonatomic,strong)NSString <Optional>*receive_address;
@property(nonatomic,strong)NSString <Optional>*receive_from;
@property(nonatomic,strong)NSString <Optional>*start_time;
@property(nonatomic,strong)NSString <Optional>*end_time;
@property(nonatomic,strong)NSString <Optional>*trade_time;
@property(nonatomic,strong)NSString <Optional>*start_seconds;
@property(nonatomic,strong)NSString <Optional>*end_seconds;
@end

@interface Seller_Seller_Goods_info : JSONModel 
@property(nonatomic,strong)NSArray<Seller_Seller_Goods_arr_goods_info,Optional> *arr_goods;
@end

@interface Seller_Seller_Goods : JSONModel 
@property(nonatomic,strong)Seller_Seller_Goods_info<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error; 
@end