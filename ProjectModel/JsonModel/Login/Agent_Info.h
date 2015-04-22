//
//  Agent_Info.h
//  Club
//
//  Created by MartinLi on 15-4-21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Agent_Info_Arr_Agent<NSObject>

@end
@interface Agent_Info_Arr_Agent : JSONModel
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *agent_id;
@property (nonatomic,strong)NSString *agent_name;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *city_name;
@property (nonatomic,strong)NSString *lifehall_id;
@property (nonatomic,strong)NSString *lifehall_name;
@end
@interface Agent_Info_Info : JSONModel
@property (nonatomic,strong)NSArray<Agent_Info_Arr_Agent>*arr_agent;
@end
@interface Agent_Info : JSONModel
@property (nonatomic,strong)NSString *error;
@property (nonatomic,strong)Agent_Info_Info*info;
@property (nonatomic,assign)NSInteger status;
@end
