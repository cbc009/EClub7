//
//  prize_Lucky_Reoly_model.h
//  Club
//
//  Created by MartinLi on 15/5/22.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@interface prize_Lucky_Reoly_Model_Info : JSONModel
@property (nonatomic,strong)NSString *prize_amount;
@end

@interface prize_Lucky_Reoly_model : JSONModel
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)prize_Lucky_Reoly_Model_Info<Optional> *info;
@end