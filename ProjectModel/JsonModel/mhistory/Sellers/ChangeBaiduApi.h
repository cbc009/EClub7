//
//  ChangeBaiduApi.h
//  Club
//
//  Created by MartinLi on 15-4-7.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Result_info <NSObject>
@end

@interface Result_info : JSONModel
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign) CGFloat y;
@end
@interface ChangeBaiduApi : JSONModel
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSArray <Result_info>*result;
@end
