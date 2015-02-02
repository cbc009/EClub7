//
//  Group_History_Goods.h
//  Club
//
//  Created by MartinLi on 15-1-9.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Group_History_Goods_Info <NSObject>
@end

@interface Group_History_Goods_Info : JSONModel
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
@end

@interface Group_History_Info : JSONModel
@property(nonatomic,strong)NSArray<Group_History_Goods_Info>* goods;
@end

@interface Group_History_Goods : JSONModel
@property(nonatomic,strong)Group_History_Info<Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *error;
@end
