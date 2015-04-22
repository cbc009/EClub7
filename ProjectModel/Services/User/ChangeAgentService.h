//
//  ChangeAgentService.h
//  Club
//
//  Created by MartinLi on 15-4-21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeAgentService : NSObject
-(void)publicProvinceInfoWithType:(NSString*)type withDone:(doneWithObject)done;
-(void)publicAgentInfoWithProvionecId:(NSString*)provinceId withDone:(doneWithObject)done;
@end
