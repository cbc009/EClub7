//
//  AdvertPic.h
//  ScrollView
//
//  Created by MartinLi on 14-11-19.
//  Copyright (c) 2014年 dengshiru. All rights reserved.
//

#import "JSONModel.h"

@protocol Picture <NSObject>
@end

@interface Picture : JSONModel
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString<Optional> *url;
@property(nonatomic,strong)NSString<Optional> *title;
@end

@interface AdvertPicInfo : JSONModel
@property(nonatomic,strong)NSArray<Picture> *picture;
@end

@interface AdvertPic : JSONModel
@property (nonatomic,strong)AdvertPicInfo *info;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong)NSString *error;
@end
