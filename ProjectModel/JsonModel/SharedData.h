//
//  SharedUser.h
//  DaXiaProject
//
//  Created by Gao Huang on 14-10-30.
//  Copyright (c) 2014年 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Login.h"
@interface SharedData : NSObject

@property(nonatomic,strong)UserInfo *user;
@property(nonatomic,strong)NSString *loginname;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *loginStatus;

@property(nonatomic,strong)NSString *iccard;
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,assign)CGFloat redbag;
+(id)sharedInstance;

@end
