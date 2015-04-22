//
//  AdvertPic.h
//  ScrollView
//
//  Created by MartinLi on 14-11-19.
//  Copyright (c) 2014年 dengshiru. All rights reserved.
//

#import "JSONModel.h"

//@protocol Picture_Arr_advert <NSObject>
//@end
@protocol Arr_Advert_info <NSObject>
@end
@interface Arr_Advert_info :JSONModel
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *url_share;
@end
@interface Picture_Arr_advert : JSONModel
@property(nonatomic,strong)NSString *position;
@property(nonatomic,strong)NSArray <Arr_Advert_info>*arr_info;
@end


@interface AdvertPicInfo : JSONModel
@property(nonatomic,strong)Picture_Arr_advert *arr_advert;
@end

@interface AdvertPic : JSONModel
@property (nonatomic,strong)AdvertPicInfo *info;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong)NSString *error;
@end
