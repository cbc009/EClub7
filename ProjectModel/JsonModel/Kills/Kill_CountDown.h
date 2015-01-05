//
//  KillCountDown.h
//  Club
//
//  Created by MartinLi on 14-10-29.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Kill_Order_Info <NSObject>
@end

@interface Kill_Order_Info : JSONModel
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *lifehall_name;
@property(nonatomic,strong)NSString *regtime;
@end


@interface Kill_CountDown_Info : JSONModel
@property(nonatomic,assign)NSInteger seconds;
@property(nonatomic,strong)NSString *gid;
//@property(nonatomic,strong)NSString *actual_num;
@property(nonatomic,strong)NSArray <Kill_Order_Info,Optional>*order;
@end

@interface Kill_CountDown : JSONModel
@property(nonatomic,strong)Kill_CountDown_Info<Optional> *info;
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;

@end
