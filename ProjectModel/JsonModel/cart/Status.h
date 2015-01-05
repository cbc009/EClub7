//
//  InCart.h
//  Club
//
//  Created by dongway on 14-8-28.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@interface OrderInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *order_id;
@end

@interface Status : JSONModel
@property(nonatomic,strong)OrderInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error;
@end
