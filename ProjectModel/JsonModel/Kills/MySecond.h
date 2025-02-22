//
//  MySecond.h
//  Club
//
//  Created by Gao Huang on 14-10-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol MySecondOrder <NSObject>
@end

@interface MySecondOrder : JSONModel
@property(nonatomic,strong)NSString *orderid;
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *regtime;
@end

@interface MySecondInfo : JSONModel
@property(nonatomic,strong)NSArray<MySecondOrder,Optional> *order;
@end

@interface MySecond : JSONModel
@property(nonatomic,strong)MySecondInfo <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end
