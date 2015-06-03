//
//  GoodsCountDownModel.h
//  Club
//
//  Created by MartinLi on 15-4-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@interface GoodsCount_Info : JSONModel
@property (nonatomic,strong)NSString <Optional>*start_second;
@property (nonatomic,strong)NSString <Optional>*end_second;
@end
@interface GoodsCountDownModel : JSONModel
@property(nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *error;
@property (nonatomic,strong)GoodsCount_Info <Optional>*info;
@end
