//
//  PointGoodsModel.h
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol Goods <NSObject>
@end

@interface Goods: JSONModel
@property (nonatomic, copy) NSString *gid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *picture;
@property (nonatomic, copy)NSString *unit;
@property (nonatomic, copy) NSString *bigpicture;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *point;
@end

@interface GoodInfo : JSONModel
@property(nonatomic,strong)NSMutableArray<Goods> *goods;
@end

@interface PointGoodsModel : JSONModel
@property (copy,nonatomic)NSString *error;
@property (assign,nonatomic)NSInteger status;
@property (strong,nonatomic)GoodInfo<Optional> *info;
@end
