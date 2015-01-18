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
-(void)loadLiveDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type andPageString:(NSString *)pageString withTabBarViewController:(UITabBarController*)tabBarController doneObject:(doneWithObject)done;
-(void)countSizeWithData:(NSMutableArray *)data inViewController:(LiveViewController *)viewController;
-(void)updateHeaderImage:(UIImage *)image withCompletion:(finished)finished;
-(void)updateBackGroundImage:(UIImage *)image withCompletion:(finished)finished;
-(void)deleteCellInLiveViewController:(LiveViewController *)viewController atIndexPath:(NSIndexPath *)indexPath;
@end
