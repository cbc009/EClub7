//
//  MyGroups.h
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol MyGroupOrder <NSObject>
@end

@interface MyGroupOrder : JSONModel
@property(nonatomic,strong)NSString *orderid;
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *nums;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *regtime;
@end

@interface MyGroupOrderInfo : JSONModel
@property(strong,nonatomic)NSArray<MyGroupOrder,Optional>* order;
@end

@interface MyGroups : JSONModel
@property(nonatomic,strong)MyGroupOrderInfo <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end

