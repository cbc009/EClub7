//
//  Seller_Info.h
//  Club
//
//  Created by MartinLi on 15-3-10.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Seller_Info_arr_seller <NSObject>
@end
@interface Seller_Info_arr_seller : JSONModel
@property (nonatomic,strong)NSString *seller_id;
@property (nonatomic,strong)NSString *seller_name;
@property (nonatomic,strong)NSString *picture;
@property (nonatomic,strong)NSString *intro;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *work_time;
@end
@interface Seller_Info_info : JSONModel
@property(nonatomic,strong)NSArray <Seller_Info_arr_seller>*arr_seller;
@end
@interface Seller_Info : JSONModel
@property(nonatomic,strong)Seller_Info_info *info;
@property (nonatomic,strong)NSString *error;
@property (nonatomic,assign)NSInteger status;
@end
