//
//  LiveService.h
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveViewController.h"
@interface LiveService : NSObject
-(void)loadLiveDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type onLiveViewController:(LiveViewController *)viewController;
@end
