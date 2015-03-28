 //
 //  Public_Seller.h 
 //  auton //
 //  Created by MartinLi on 15-3-5. 
 //  Copyright (c) 2015年 Club. All rights reserved.
 //
#import "JSONModel.h"

@protocol Public_Seller_arr_seller_type_info <NSObject>
@end
@protocol Public_Seller_sub_type_info <NSObject>
@end
@interface Public_Seller_sub_type_info : JSONModel
@property(nonatomic,strong)NSString *sub_type_id;
@property(nonatomic,strong)NSString *sub_type_name;

@end

@interface Public_Seller_arr_seller_type_info : JSONModel
@property(nonatomic,strong)NSString *seller_type_name;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *seller_type;
@property(nonatomic,strong)NSArray <Public_Seller_sub_type_info,Optional>*sub_type;
@property(nonatomic,strong)NSString <Optional>*color;
@end

@interface Public_Seller_info : JSONModel 
@property(nonatomic,strong)NSArray<Public_Seller_arr_seller_type_info> *arr_seller_type; 
@end

@interface Public_Seller : JSONModel 
@property(nonatomic,strong)Public_Seller_info<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error; 
@end