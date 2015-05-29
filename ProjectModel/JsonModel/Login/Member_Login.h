//
//  Login3.h
//  Club
//
//  Created by Gao Huang on 14-11-19.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@interface UserInfo : JSONModel
@property(nonatomic,strong)NSString *loginname;
@property(nonatomic,assign)NSInteger user_type;
@property(nonatomic,assign)NSInteger agent_id;
@property(nonatomic,strong)NSString *agent_name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,assign)NSInteger mid;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *life_picture;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *iccard;
@property(nonatomic,assign)float amount;
@property(nonatomic,assign)float amount_red;
@property(nonatomic,assign)NSInteger point;
@property(nonatomic,assign)NSInteger phone_minute;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,assign)NSInteger city;
@property(nonatomic,strong)NSString *city_name;
@property(nonatomic,assign)NSInteger lifehall_id;
@property(nonatomic,strong)NSString *lifehall_name;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *lifehall_address;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *version_name;
@property(nonatomic,assign)NSInteger version_key;
@property(nonatomic,strong)NSString *token;
@end


@interface Member_Login : JSONModel
@property(nonatomic,strong)UserInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *error;
@end
