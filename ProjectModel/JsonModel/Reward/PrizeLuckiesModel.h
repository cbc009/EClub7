//
//  PrizeLuckiesModel.h
//  Club
//
//  Created by MartinLi on 15/5/21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@interface PrizeLuckiesInfo : JSONModel
@property (nonatomic,strong)NSString *prize_amount;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger prize_id;
@end
@interface PrizeLuckiesModel : JSONModel
@property (nonatomic,strong)NSString *error;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)PrizeLuckiesInfo *info;
@end
