//
//  Public_lifehall.h
//  Club
//
//  Created by MartinLi on 15-3-11.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Public_Lifehall_INfo_arr_lifehall <NSObject>
@end
@interface Public_Lifehall_INfo_arr_lifehall : JSONModel
@property (nonatomic,strong)NSString *lifehall_id;
@property (nonatomic,strong)NSString *lifehall_name;
@property (nonatomic,strong)NSString *picture;
@property (nonatomic,strong)NSString *intro;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *address;
@end
@interface Public_Lifehall_INfo : JSONModel
@property(nonatomic,strong)NSArray <Public_Lifehall_INfo_arr_lifehall>*arr_lifehall;
@end
@interface Public_lifehall : JSONModel
@property (nonatomic,strong)NSString *error;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)Public_Lifehall_INfo*info;
@end
