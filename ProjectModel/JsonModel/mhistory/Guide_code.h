//
//  Guide_code.h
//  Club
//
//  Created by MartinLi on 15-1-5.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Member_info <NSObject>

@end
@interface Member_info : JSONModel
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *nickname;
@property (nonatomic,retain)NSString *regtime;
@end
@interface GUIde_info : JSONModel
@property(nonatomic,strong)NSArray <Member_info,Optional>*member;
@property(nonatomic,strong)NSString *qrcode;
@end
@interface Guide_code : JSONModel
@property (nonatomic,strong)NSString *error;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)GUIde_info *info;
@end
