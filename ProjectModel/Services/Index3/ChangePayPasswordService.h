//
//  ChangePayPasswordService.h
//  Club
//
//  Created by apple on 14-11-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangePayPasswordViewController.h"
@interface ChangePayPasswordService : NSObject
-(void)changePassword:(NSString *)oldpassword andnewPassword:(NSString *)newpasswd andnewpassword2:(NSString *)newpassword2 onChangePayPasswordViewcontroller:(ChangePayPasswordViewController *)ChangePayPasswordViewController;
@end
