 //
 //  Seller_Order_model.h 
 //  auton //
 //  Created by MartinLi on 15-3-5. 
 //  Copyright (c) 2015年 Club. All rights reserved.
 //
 #import "JSONModel.h"

@protocol Seller_Order_model_arr_order_info <NSObject>
@end

@interface Seller_Order_model_arr_order_info : JSONModel
@property(nonatomic,strong)NSString *goods_name;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString *receive_address;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,strong)NSString *goods_type_name;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *receive_url;
@property(nonatomic,strong)NSString *point;
@property(nonatomic,strong)NSString *goods_id;
@property(nonatomic,strong)NSString *actual_nums;
@property(nonatomic,strong)NSString *oprt_time;
@property(nonatomic,strong)NSString *seller_id;
@property(nonatomic,strong)NSString *receive_time;
@property(nonatomic,strong)NSString *regtime;
@property(nonatomic,strong)NSString *status_name;
@property(nonatomic,strong)NSString *goods_type;
@property(nonatomic,strong)NSString *seller_name;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *seller_picture;
@property(nonatomic,strong)NSString *seller_intro;
@property(nonatomic,assign)CGFloat amount_total;
@property(nonatomic,assign)CGFloat amount;
@property(nonatomic,assign)CGFloat amount_red;
@property(nonatomic,assign)CGFloat amount_point;
@end

@interface Seller_Order_model_info : JSONModel 
@property(nonatomic,strong)NSArray<Seller_Order_model_arr_order_info,Optional> *arr_order;
@end

@interface Seller_Order_model : JSONModel 
@property(nonatomic,strong)Seller_Order_model_info<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error; 
@end