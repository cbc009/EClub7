//
//  Goods_type.h
//  Club
//
//  Created by Gao Huang on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol Goods_type_goods_type <NSObject>
@end
@protocol Goods_type_subType <NSObject>
@end

@interface Goods_type_subType : JSONModel
@property(nonatomic,strong)NSString *subid;
@property(nonatomic,strong)NSString *name;
@end
@interface Goods_type_goods_type : JSONModel
@property(nonatomic,strong)NSString *mainid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *color;
@property(nonatomic,strong)NSArray<Goods_type_subType>* subtype;
@end

@interface Goods_type_info : JSONModel
@property(nonatomic,strong)NSArray<Goods_type_goods_type>* goods_type;
@end

@interface Goods_type : JSONModel
@property(nonatomic,strong)Goods_type_info <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end
