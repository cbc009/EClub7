//
//  Partner_list_Model.h
//  Club
//
//  Created by MartinLi on 15-1-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Partner_Info <NSObject>
@end

@interface Partner_Info : JSONModel
@property(nonatomic,strong)NSString *partner_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *picture;
@end
@interface Partner_list_Info : JSONModel
@property(nonatomic,strong)NSArray<Partner_Info>*partner;
@end
@interface Partner_list_Model : JSONModel
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)Partner_list_Info *info;
@end
