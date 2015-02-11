//
//  RobModel.h
//  Club
//
//  Created by MartinLi on 15-1-3.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol RobModelInfo <NSObject>
@end
@interface RobModelInfo : JSONModel
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *nums;
@property (copy, nonatomic) NSString *qiang;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *picture;
@property (copy, nonatomic) NSString *starttime;
@property (copy, nonatomic) NSString *endtime;
@property (copy, nonatomic) NSString *unit;
@property (copy, nonatomic) NSString *discount;
@property (nonatomic,assign) NSInteger seconds;
@property (copy, nonatomic) NSString *gid;
@property (copy, nonatomic) NSString *intro;
@property (copy, nonatomic) NSString *point;
@end
//@protocol RobModelInfo : JSONModel
//@property (copy, nonatomic) RobModelInfo<> *info;
//@end
@interface RobModel : JSONModel
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *error;
@property (nonatomic,strong)RobModelInfo<Optional>*info;
@end