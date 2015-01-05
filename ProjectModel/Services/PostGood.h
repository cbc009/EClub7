//
//  PostGood.h
//  Club
//
//  Created by MartinLi on 14-12-21.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostViewController.h"
#import "PostbuyViewController.h"
@interface PostGood : NSObject
-(void)postGoodWithmid:(NSInteger )mid andSid:(NSInteger )sid andTitle:(NSString *)title andContent:(NSString *)content andDegree:(NSString *)degree andPrice:(NSString *)price andName:(NSString *)name andMobile:(NSString *)mobile andImageArray:(NSArray *)imageArray onViewController:(PostViewController *)viewcontroller;
-(void)postGoodWithmid:(NSInteger )mid andSid:(NSInteger )sid andTitle:(NSString *)title andContent:(NSString *)content andDegree:(NSString *)degree andPrice:(NSString *)price andName:(NSString *)name andMobile:(NSString *)mobile onViewController:(PostbuyViewController *)viewcontroller;
@end
