//
//  LifehallModel.h
//  Club
//
//  Created by MartinLi on 15-1-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@protocol Life_Hall_Info <NSObject>

@end
@interface Life_Hall_Info : JSONModel
@property(nonatomic,strong)NSString *lifehall_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *picture;
@end
@interface LifeHall_List_Info : JSONModel
@property(nonatomic,strong)NSArray<Life_Hall_Info>*lifehall;
@end
@interface LifehallModel : JSONModel
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)LifeHall_List_Info *info;
@end
