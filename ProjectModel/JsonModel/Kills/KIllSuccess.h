//
//  KIllSuccess.h
//  Club
//
//  Created by MartinLi on 15-1-5.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Success_Member_info <NSObject>
@end
@interface Success_Member_info : JSONModel
@property (nonatomic,strong)NSString *picture;
@property (nonatomic,strong)NSString *nickname;
@end

@interface KillSuccess_Info : JSONModel
@property (nonatomic,strong)NSArray<Success_Member_info,Optional> *member;
@end

@interface KIllSuccess : JSONModel
@property (nonatomic,strong)NSString *error;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)KillSuccess_Info<Optional>*info;
@end
