//
//  PointVIewControllerService.h
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PointViewController.h"
@interface PointVIewControllerService : NSObject
-(void)presentPointGoodViewControllerWithDatas:(NSDictionary *)dic OnPointViewController:(PointViewController *)viewController;

-(void)loadDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPage:(NSString *)page OnViewCOntroller:(PointViewController *)viewController;
-(void)loadMoreDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPage:(NSString *)page OnViewCOntroller:(PointViewController *)viewController;
@end
