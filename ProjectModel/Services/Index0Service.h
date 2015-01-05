//
//  Index0Service.h
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MartinLiPageScrollView.h"
#import "Index0_3ViewController.h"
@interface Index0Service : NSObject

-(void)loadUserDefaultsInViewController:(UIViewController *)viewController;
-(void)loadAdverPicWithPos:(NSInteger)pos andCity:(NSInteger)city inViewController:(UIViewController *)viewController;
//-(void)GetBalanceWithToken:(NSString *)token andUser_type:(NSInteger )user_type onViewController:(Index0_3ViewController *)viewController;

-(NSArray *)namesFromPictures:(NSArray *)pictures;
-(NSArray *)titlesFromPictures:(NSArray *)pictures;
-(NSArray *)urlsFromPictures:(NSArray *)pictures;
@end
