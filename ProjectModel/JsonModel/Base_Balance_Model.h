//
//  Base_Balance_Model.h
//  Club
//
//  Created by MartinLi on 15-1-14.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"


@interface Base_Balance_Info : JSONModel
@property(nonatomic,strong)NSString<Optional> *iccard;
@property(nonatomic,assign)CGFloat amount;
@property(nonatomic,assign)CGFloat amount_red;
@property(nonatomic,assign)CGFloat point;
@property(nonatomic,assign)NSInteger phone_minute;
@end

@interface Base_Balance_Model : JSONModel
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)Base_Balance_Info <Optional>*info;
@end
