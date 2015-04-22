//
//  TypeGoods.h
//  Club
//
//  Created by MartinLi on 15-4-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"

@interface Type_Goods_info_Good : JSONModel
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *bigpicture;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *unit_num;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,assign)NSInteger goods_new;
@property(nonatomic,strong)NSString <Optional>*logistics;
@property(nonatomic,strong)NSString <Optional>*url;
@property(nonatomic,strong)NSString <Optional>*share_url;
@property(nonatomic,strong)NSString <Optional>*nums;
@end

@interface Type_Goods_info : JSONModel
@property(nonatomic,strong)Type_Goods_info_Good *goods;
@end

@interface TypeGoods : JSONModel
@property(nonatomic,strong)Type_Goods_info <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end
