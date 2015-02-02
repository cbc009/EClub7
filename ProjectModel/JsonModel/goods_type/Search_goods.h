//
//  Search_goods.h
//  Club
//
//  Created by MartinLi on 14-12-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//


#import "JSONModel.h"
#import "Type_goods.h"
@protocol Search_goods_good <NSObject>

@end

//@interface Search_goods_good : JSONModel
//@property(nonatomic,strong)NSString *gid;
//@property(nonatomic,strong)NSString *name;
//@property(nonatomic,strong)NSString *picture;
//@property(nonatomic,strong)NSString *price;
//@property(nonatomic,strong)NSString *bigpicture;
//@property(nonatomic,strong)NSString *discount;
//@property(nonatomic,strong)NSString *unit;
//@property(nonatomic,strong)NSString *unit_num;
//@property(nonatomic,assign)NSInteger goods_new;
//@property(nonatomic,strong)NSString *url;
//@property(nonatomic,strong)NSString *logistics;
////@property(nonatomic,strong)NSString *nums;
//@end

@interface Search_goods_info : JSONModel
@property(nonatomic,strong)NSArray<Type_goods_good> *goods;
@end

@interface Search_goods : JSONModel
@property(nonatomic,strong)Search_goods_info <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@end
