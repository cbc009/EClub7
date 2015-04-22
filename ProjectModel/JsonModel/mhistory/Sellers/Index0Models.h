//
//  Index0Models.h
//  Club
//
//  Created by MartinLi on 15-4-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Index0Models_Arr_Goods_info <NSObject>
@end
@protocol Index0Models_Arr_Seller_info <NSObject>
@end
@interface Index0Models_Arr_Seller_info : JSONModel
@property (nonatomic,strong)NSString *seller_id;
@property (nonatomic,strong)NSString *seller_name;
@property (nonatomic,strong)NSString *picture;
@end

@interface Index0Models_Arr_Goods_info : JSONModel
@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic,strong)NSString *picture;
@property (nonatomic,strong)NSString *unit;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *discount;
@property (nonatomic,strong)NSString *actual_nums;
@end



@interface Index0Models_Arr_Model_Team_info : JSONModel
@property (nonatomic,strong)NSString *picture;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *sub_title;
@end

@interface Index0Models_Arr_Model_info : JSONModel
@property (nonatomic,strong)Index0Models_Arr_Model_Team_info <Optional>*team;
@property (nonatomic,strong)Index0Models_Arr_Model_Team_info <Optional>*robuy;
@property (nonatomic,strong)Index0Models_Arr_Model_Team_info <Optional>*second;
@property (nonatomic,strong)Index0Models_Arr_Model_Team_info <Optional>*exchange;
@property (nonatomic,strong)Index0Models_Arr_Model_Team_info <Optional>*newgoods;
@end

@interface Index0Models_info : JSONModel
@property (nonatomic,strong)Index0Models_Arr_Model_info <Optional>*arr_model;
@property (nonatomic,strong)NSArray<Index0Models_Arr_Seller_info>*arr_seller;
@property (nonatomic,strong)NSArray<Index0Models_Arr_Goods_info> *arr_goods;
@end
@interface Index0Models : JSONModel
@property(nonatomic,strong)Index0Models_info<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error;
@end
