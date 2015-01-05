//
//  CreatePayService.h
//  Club
//
//  Created by Gao Huang on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatePayService : NSObject
-(void)loadCreatePayOrderInfoWithMid:(NSInteger )mid andPrice:(NSString *)price finished:(doneWithObject)done;

-(void)reloadAmoutAfterPopToViewControllerInNav:(UINavigationController *)nav;

@end
