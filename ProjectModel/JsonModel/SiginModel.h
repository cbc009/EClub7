//
//  SiginModel.h
//  Club
//
//  Created by MartinLi on 14-12-8.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@interface SiginIfo : JSONModel
@property (nonatomic ,assign)NSInteger minutes;
@end
@interface SiginModel : JSONModel
@property (nonatomic ,strong) NSString *error;
@property (nonatomic ,assign) NSInteger status;
@property (nonatomic ,strong) SiginIfo *info;
@end
