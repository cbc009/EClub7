//
//  Province_Info.h
//  Club
//
//  Created by MartinLi on 15-4-21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Province_Arr_Province<NSObject>
@end
@interface Province_Arr_Province : JSONModel
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *province_name;
@end
@interface Province_JSON_Info : JSONModel
@property (nonatomic,strong)NSArray <Province_Arr_Province>*arr_province;
@end

@interface Province_Info : JSONModel
@property (nonatomic,strong)Province_JSON_Info*info;
@property (nonatomic,strong)NSString *error;
@property (nonatomic,assign)NSInteger status;
@end
