//
//  SecondeService.h
//  Club
//
//  Created by MartinLi on 14-12-21.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecondeChangeViewController.h"
#import "MysecondeViewController.h"
@interface SecondeService : NSObject
-(void)loadDataWithSid:(NSInteger )sid andPage:(NSString *)page onSecondeChangeViewController:(SecondeChangeViewController *)viewController;
-(void)loadBuyDataWithSid:(NSInteger )sid andPage:(NSString *)page onSecondeChangeViewController:(SecondeChangeViewController *)viewController;
-(void)loadMyTransDataWithMid:(NSInteger )mid andPage:(NSString *)page onMysecondeViewController:(MysecondeViewController *)viewController;
-(void)loadMyBuyDataWithMid:(NSInteger )mid andPage:(NSString *)page onMysecondeViewController:(MysecondeViewController *)viewController;
@end
