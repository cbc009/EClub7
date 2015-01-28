//
//  KillHistorModel.h
//  Club
//
//  Created by MartinLi on 14-12-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol KillGood1 <NSObject>
@end

@interface KillGood1 : JSONModel
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
@property(nonatomic,strong)NSString *logistics;
@property(nonatomic,strong)NSString *starttime;
@end

@interface KillGoodInfo1 : JSONModel
@property(nonatomic,strong)NSArray<KillGood1,Optional>*goods;
@end

@interface KillHistorModel : JSONModel
@property(nonatomic,strong)KillGoodInfo1 <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;
@end
