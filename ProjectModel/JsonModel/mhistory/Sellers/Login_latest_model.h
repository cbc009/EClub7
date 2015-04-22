//
//  Login_latest_model.h
//  Club
//
//  Created by MartinLi on 15-4-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol Login_latest_model_Arr_Goods_Info <NSObject>

@end
@interface Login_latest_model_Arr_Goods_Info : JSONModel
@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic,strong)NSString *unit;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *discount;
@property (nonatomic,strong)NSString *picture;
@property (nonatomic,strong)NSString *actual_nums;
@end

@interface Login_latest_model_info : JSONModel
@property (nonatomic,strong)NSArray <Login_latest_model_Arr_Goods_Info>*arr_goods;
@end
@interface Login_latest_model : JSONModel
@property (nonatomic,strong)NSString *error;
@property (nonatomic,strong)Login_latest_model_info *info;
@property (nonatomic,assign)NSInteger status;
@end
