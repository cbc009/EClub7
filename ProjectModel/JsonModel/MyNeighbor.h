//
//  MyNeighbor.h
//  Club
//
//  Created by MartinLi on 14-12-8.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"


@protocol  Member<NSObject>

@end

@interface Member : JSONModel
@property (nonatomic ,strong) NSString *nid;
@property (nonatomic ,strong) NSString *loginname;
@property (nonatomic ,strong) NSString *nickname;
@property (nonatomic ,strong) NSString *picture;

@property (nonatomic ,strong) NSString *focus;
@property (nonatomic ,assign) NSInteger status;
@property (nonatomic ,strong) NSString *bfocus;
@end
@interface MyNeighborInfo : JSONModel
@property(nonatomic,strong)NSArray<Member>* members;
@end

@interface MyNeighbor : JSONModel
@property (nonatomic ,strong) MyNeighborInfo<Optional> *info;
@property (nonatomic ,assign) NSInteger status;
@end
