//
//  Mhistory.h
//  Club
//
//  Created by MartinLi on 14-8-30.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol PastItem <NSObject>
@end

@interface PastItem : JSONModel
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString <Optional>*picture;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *point;
@property(nonatomic,strong)NSString *starttime;
@end

@interface Rob_goods_history_info : JSONModel
@property(nonatomic,strong)NSArray<PastItem> *goods;
@end

@interface Rob_goods_history : JSONModel
@property(nonatomic,strong)Rob_goods_history_info<Optional> *info;
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@end
