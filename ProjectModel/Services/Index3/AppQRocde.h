//
//  AppQRocde.h
//  Club
//
//  Created by MartinLi on 15-1-5.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppViewController.h"
@interface AppQRocde : NSObject
-(void)loadDataWithToken:(NSString *)token AndUser_type:(NSInteger )user_type withDone:(doneWithObject)done;
@end
