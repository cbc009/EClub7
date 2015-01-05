//
//  Cart.h
//  Club
//
//  Created by dongway on 14-8-28.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol  Good<NSObject>

@end
@interface Good : JSONModel
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSString *cid;
@end

@interface CartInfo : JSONModel
@property(nonatomic,assign)CGFloat redbag;
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSArray<Good>*goods;
@end


@interface Cart : JSONModel
@property(nonatomic,strong)CartInfo *info;
@property(nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *error;
@end
