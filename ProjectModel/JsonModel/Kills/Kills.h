//
//  Kills.h
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol KillGood <NSObject>
@end

@interface KillGood : JSONModel
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *bigpicture;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *expect_num;
@property(nonatomic,strong)NSString *actual_num;
@property(nonatomic,strong)NSString<Optional> *starttime;
@property(nonatomic,assign)int seconds;
@end

@interface KillGoodInfo : JSONModel
@property(nonatomic,strong)NSArray<KillGood,Optional>* goods;
@end

@interface Kills : JSONModel
@property(nonatomic,strong)KillGoodInfo <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end

