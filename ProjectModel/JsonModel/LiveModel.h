//
//  LiveModel.h
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Picture_Info <NSObject>

@end
@protocol CommentInfo <NSObject>
@end
@protocol DataInfo <NSObject>
@end
@interface CommentInfo : JSONModel
@property (nonatomic,strong)NSString <Optional>*nickname;
@property (nonatomic,strong)NSString <Optional>*regtime;
@property (nonatomic,strong)NSString <Optional>*content;
@end

@interface Picture_Info : JSONModel
@property (nonatomic,strong)NSString <Optional>*picture;
@end
@interface DataInfo : JSONModel
@property(nonatomic,strong)NSString *mid;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *headpic;
@property(nonatomic,strong)NSString *xid;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *regtime;
@property(nonatomic,strong)NSArray<Picture_Info,Optional>*picture;
@property(nonatomic,strong)NSArray<CommentInfo,Optional>*comment;
@end
@interface LiveModelInfo : JSONModel
@property (nonatomic,strong)NSArray<DataInfo> *data;
@property (nonatomic,strong)NSString <Optional>*life_picture;
@property(nonatomic,strong)NSString <Optional>*mid;
@property(nonatomic,strong)NSString <Optional>*nickname;
@property(nonatomic,strong)NSString <Optional>*headpic;
@end

@interface LiveModel : JSONModel
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)LiveModelInfo*info;
@end
