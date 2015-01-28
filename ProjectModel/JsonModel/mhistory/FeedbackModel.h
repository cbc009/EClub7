//
//  FeedbackModel.h
//  Club
//
//  Created by MartinLi on 15-1-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Advice_Info <NSObject>
@end
@interface Advice_Info : JSONModel
@property (nonatomic,strong)NSString*regtime;
@property (nonatomic,strong)NSString*content;
@property (nonatomic,strong)NSString*reply;
@property (nonatomic,strong)NSString*oprttime;
@end
@interface Feedback_info : JSONModel

@property (nonatomic,strong)NSArray<Advice_Info,Optional>*advice;
@end
@interface FeedbackModel : JSONModel
@property (nonatomic,strong)NSString *error;
@property (nonatomic,strong)Feedback_info *info;
@property (nonatomic,assign)NSInteger status;
@end
