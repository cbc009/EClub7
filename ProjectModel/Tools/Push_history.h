//
//  Push_history.h
//  Club
//
//  Created by MartinLi on 14-11-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"


@protocol push <NSObject>
@end


@interface push : JSONModel
@property (nonatomic ,copy)NSString *notice_id;
@property (nonatomic ,copy)NSString *content;
@property (nonatomic ,copy)NSString *regtime;
@property (nonatomic ,copy)NSString *title;
@end


@interface PushInfo : JSONModel
@property(nonatomic,strong)NSMutableArray<push,Optional> *arr_info;
@end

@interface Push_history : JSONModel
@property (nonatomic ,copy)PushInfo <Optional>*info;
@property (nonatomic ,assign) NSInteger status;
@property (nonatomic ,strong)NSString *error;
@end