//
//  Mhistory.h
//  Club
//
//  Created by MartinLi on 14-8-30.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@protocol Member_Info <NSObject>

@end
@interface Member_Info : JSONModel
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *regtime;

@end
@interface Rob_Record_Info : JSONModel
@property(nonatomic,strong)NSArray<Member_Info> *member;
@end

@interface Member_History : JSONModel
@property(nonatomic,strong)Rob_Record_Info <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *error;

@end
