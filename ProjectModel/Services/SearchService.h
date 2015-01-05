//
//  SearchService.h
//  Club
//
//  Created by MartinLi on 14-12-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SerchViewController.h"
@interface SearchService : NSObject

-(void)goodsSearchWithToken:(NSString *)token andUser_type:(NSInteger )user_type anName:(NSString *)name withDoneObject:(doneWithObject)done;
@end
