//
//  RewardData.h
//  Club
//
//  Created by dongway on 14-9-2.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol Prize <NSObject>
@end
@interface Prize : JSONModel
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *amount_red;
@end

@protocol Rotary <NSObject>
@end
@interface Rotary : JSONModel
@property(nonatomic,strong)NSString *serialid;
@property(nonatomic,strong)NSString *cash;
@end

@interface PrizeIndexInfo : JSONModel
@property(nonatomic,strong)NSArray<Prize>* prize;
@property(nonatomic,strong)NSArray<Rotary>* rotary;
@property(nonatomic,assign)long peoples;
@property(nonatomic,assign)int nums;
@end

@interface PrizeIndex : JSONModel
@property(nonatomic,strong)PrizeIndexInfo* info;
@property(nonatomic,assign)NSInteger status;
@end
