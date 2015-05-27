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
@property(nonatomic,strong)NSString <Optional>*intro;
@property(nonatomic,strong)NSString <Optional>*seller_status;
@property(nonatomic,strong)NSString <Optional>*phone;
@property(nonatomic,assign)NSInteger neat_praises;
@property(nonatomic,assign)NSInteger descrip_praises;
@property(nonatomic,strong)NSString <Optional>*picture;
@property(nonatomic,strong)NSString <Optional>*longitude;
@property(nonatomic,strong)NSString <Optional>*street;
@property(nonatomic,strong)NSString <Optional>*latitude;
@property(nonatomic,strong)NSString <Optional>*address;
@property(nonatomic,strong)NSString <Optional>*sub_type_name;
@property(nonatomic,strong)NSString <Optional>*work_time;
@property(nonatomic,assign)NSInteger total_praises;
@property(nonatomic,strong)NSString <Optional>*receive_time;
@property(nonatomic,strong)NSString <Optional>*distance;
@property(nonatomic,strong)NSString <Optional>*seller_id;
@property(nonatomic,strong)NSString <Optional>*seller_name;
@property(nonatomic,strong)NSString <Optional>*logistics;
@end

@interface Public_Seller_info_model_info : JSONModel 
@property(nonatomic,strong)NSArray<Public_Seller_info_model_arr_seller_info,Optional> *arr_seller;
@end

@interface Public_Seller_info_model : JSONModel 
@property(nonatomic,strong)Public_Seller_info_model_info<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error; 
@end