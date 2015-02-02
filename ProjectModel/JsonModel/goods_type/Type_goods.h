//
//  Type_goods.h
//  Club
//
//  Created by Gao Huang on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol Type_goods_good <NSObject>

@end

@interface Type_goods_good : JSONModel
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
@property(nonatomic,strong)NSString <Optional>*nums;
@end

@interface Type_goods_info : JSONModel
@property(nonatomic,strong)NSArray<Type_goods_good> *goods;
@end

@interface Type_goods : JSONModel
@property(nonatomic,strong)Type_goods_info <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end
