//
//  CallPhone.h
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@interface CallPhone : JSONModel
@property (nonatomic ,strong) NSString *error;
@property (nonatomic ,assign) NSInteger status;
@end
