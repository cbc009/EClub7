//
//  SecondeChange.h
//  Club
//
//  Created by MartinLi on 14-12-21.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol TransInfo <NSObject>
@end
@protocol PictureInfo <NSObject>
@end
@interface PictureInfo : JSONModel
@property(nonatomic,strong)NSString<Optional>*picture;
@end
@interface TransInfo : JSONModel
@property(nonatomic,strong)NSString*tid;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*content;
@property(nonatomic,strong)NSString*degree;
@property(nonatomic,strong)NSString*price;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*mobile;
@property(nonatomic,strong)NSString*regtime;
@property(nonatomic,strong)PictureInfo<Optional>*picture;
@end

@interface TransInfos : JSONModel
@property(nonatomic,strong)NSArray<TransInfo,Optional>*trans;
@end

@interface SecondeChange : JSONModel
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,copy)TransInfos* info;
@end
