//
//  CallhistoryModel.h
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol  Data_Info<NSObject>

@end

@interface Data_Info : JSONModel
@property (nonatomic ,strong) NSString *callid;
@property (nonatomic ,strong) NSString *phone;
@property (nonatomic ,strong) NSString *regtime;
@property (nonatomic ,strong) NSString *minutes;
@property (nonatomic ,strong) NSString *name;
@end
@interface Call_History_Info : JSONModel
@property(nonatomic,strong)NSArray<Data_Info>*data;
@end
@interface Call_history_Model : JSONModel
@property (nonatomic ,strong) Call_History_Info*info;
@property (nonatomic ,strong) NSString *error;
@property (nonatomic ,assign) NSInteger status;
@end
