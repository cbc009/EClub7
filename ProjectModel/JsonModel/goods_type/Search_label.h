//
//  Search_label.h
//  Club
//
//  Created by MartinLi on 15-1-30.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Search_Goods_Info <NSObject>
@end

@interface Search_Goods_Info : JSONModel
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *name;
@end

@interface Search_Label_Info : JSONModel
@property(nonatomic,strong)NSArray <Search_Goods_Info>*goods;
@end

@interface Search_label : JSONModel
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)Search_Label_Info *info;
@end
