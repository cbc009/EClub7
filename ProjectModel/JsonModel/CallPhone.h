//
//  CallPhone.h
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@interface Phones_Info : JSONModel

@end
@interface CallPhone : JSONModel
@property (nonatomic ,strong) NSString *error;
@property (nonatomic ,assign) NSInteger status;
@property (nonatomic ,strong) Phones_Info<Optional> *info;
@end
