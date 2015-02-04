//
//  SomeoneContent.h
//  Club
//
//  Created by MartinLi on 15-2-3.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Pictures_Info <NSObject>
@end
@protocol CommentsInfo <NSObject>
@end
//@protocol DatasInfo <NSObject>
//@end
@interface CommentsInfo : JSONModel
@property (nonatomic,strong)NSString <Optional>*nickname;
@property (nonatomic,strong)NSString <Optional>*regtime;
@property (nonatomic,strong)NSString <Optional>*content;
@end

@interface Pictures_Info : JSONModel
@property (nonatomic,strong)NSString <Optional>*picture;
@end
@interface DatasInfo : JSONModel
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *headpic;
@property(nonatomic,strong)NSString <Optional>*xid;
@property(nonatomic,strong)NSString <Optional>*content;
@property(nonatomic,strong)NSString <Optional>*regtime;
@property(nonatomic,strong)NSArray<Pictures_Info,Optional>*picture;
@property(nonatomic,strong)NSArray<CommentsInfo,Optional>*comment;
@end
@interface SomeoneContentModelInfo :JSONModel
@property (nonatomic,strong)DatasInfo*data;
@end
@interface SomeoneContent : JSONModel
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)SomeoneContentModelInfo<Optional>*info;
@end
