 //
 //  Public_Seller_info_model.h 
 //  auton //
 //  Created by MartinLi on 15-3-5. 
 //  Copyright (c) 2015年 Club. All rights reserved.
 //
 #import "JSONModel.h"

 @protocol Public_Seller_info_model_arr_seller_info <NSObject>
@end

@interface Public_Seller_info_model_arr_seller_info : JSONModel

@property(nonatomic,assign)NSInteger attitude_praises;
@property(nonatomic,strong)NSString *intro;
@property(nonatomic,strong)NSString *seller_status;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,assign)NSInteger neat_praises;
@property(nonatomic,assign)NSInteger descrip_praises;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString <Optional>*street;
@property(nonatomic,strong)NSString *latitude;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *sub_type_name;
@property(nonatomic,strong)NSString *work_time;
@property(nonatomic,assign)NSInteger total_praises;
@property(nonatomic,strong)NSString *receive_time;
@property(nonatomic,strong)NSString *distance;
@property(nonatomic,strong)NSString *seller_id;
@property(nonatomic,strong)NSString *seller_name;
@property(nonatomic,strong)NSString *logistics;
@end

@interface Public_Seller_info_model_info : JSONModel 
@property(nonatomic,strong)NSArray<Public_Seller_info_model_arr_seller_info,Optional> *arr_seller;
@end

@interface Public_Seller_info_model : JSONModel 
@property(nonatomic,strong)Public_Seller_info_model_info<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error; 
@end