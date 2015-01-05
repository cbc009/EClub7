//
//  MorePush_historyService.h
//  Club
//
//  Created by MartinLi on 14-11-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MorePush_history.h"
@interface MorePush_historyService : NSObject
-(void)loadPush_historyWithsid:(NSInteger )sid andPage:(NSString *)page InViewController:(MorePush_history *)viewController;
-(void)loadMorePush_historyWithsid:(NSInteger )sid andPage:(NSString *)page InViewController:(MorePush_history *)viewController;
@end
