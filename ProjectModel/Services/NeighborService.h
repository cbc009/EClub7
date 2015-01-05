//
//  NeighborService.h
//  Club
//
//  Created by MartinLi on 14-12-8.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyneighborViewController.h"
@interface NeighborService : NSObject
-(void)loadNeighborPhoneWithMId:(NSInteger )mid andSid:(NSInteger )sid andPage:(NSString *)page OnViewController:(MyneighborViewController*)viewController;
-(void)loadMoreNeighborPhoneWithMId:(NSInteger )mid andSid:(NSInteger )sid andPage:(NSString *)page OnViewController:(MyneighborViewController*)viewController;
@end
