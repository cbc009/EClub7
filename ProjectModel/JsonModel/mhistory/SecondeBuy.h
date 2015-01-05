//
//  SecondeBuy.h
//  Club
//
//  Created by MartinLi on 14-12-24.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol buysInfo <NSObject>
@end

@protocol picturesInfo <NSObject>
@end
@interface picturesInfo : JSONModel
@property(nonatomic,strong)NSString<Optional>*picture;
@end
@interface buysInfo : JSONModel
@property(nonatomic,strong)NSString*tid;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*content;
@property(nonatomic,strong)NSString*degree;
@property(nonatomic,strong)NSString*price;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*mobile;
@property(nonatomic,strong)NSString*regtime;
@property(nonatomic,strong)picturesInfo<Optional>*picture;
@end

@interface BuyInfo : JSONModel
@property(nonatomic,strong)NSArray<buysInfo>*buy;
@end
@interface SecondeBuy : JSONModel
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,copy)BuyInfo*info;
@end
