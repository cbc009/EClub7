//
//  Groups.h
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol Group_Good_Info <NSObject>
@end

@interface Group_Good_Info : JSONModel
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *discount;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *bigpicture;
@property(nonatomic,strong)NSString *start_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *expect_num;
@property(nonatomic,strong)NSString *actual_num;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *isrepeat;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int seconds;
@end

@interface Groups_Info : JSONModel
@property(nonatomic,strong)NSArray<Group_Good_Info>* goods;
@end

@interface Groups_Goods : JSONModel
@property(nonatomic,strong)Groups_Info<Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *error;
@end
