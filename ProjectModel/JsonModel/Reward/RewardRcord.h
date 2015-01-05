//
//  RewardRcord.h
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol LuckyInfo <NSObject>
@end

@interface LuckyInfo : JSONModel
@property(nonatomic,strong)NSString *cash;
@property(nonatomic,strong)NSString *regtime;
@end
@interface RewardRcordInfo : JSONModel
@property(nonatomic,strong)NSArray<LuckyInfo> *lucky;
@end

@interface RewardRcord : JSONModel
@property(nonatomic,strong)RewardRcordInfo *info;
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@end
