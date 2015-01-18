//
//  Prize_Lucky_Model.h
//  Club
//
//  Created by MartinLi on 15-1-6.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "JSONModel.h"
@interface Prize_Model_Info : JSONModel
@property (assign, nonatomic) long peoples;
@property (assign, nonatomic) NSInteger nums;
@property (strong, nonatomic) NSString *serialid;
@end

@interface Prize_Lucky_Model : JSONModel
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)Prize_Model_Info *info;
@end
