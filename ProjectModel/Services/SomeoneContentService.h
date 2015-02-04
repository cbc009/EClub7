//
//  SomeoneContentService.h
//  Club
//
//  Created by MartinLi on 15-2-3.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SomeoneContentService : NSObject
-(void)lifecircleLifeInfoWithToken:(NSString *)token andXid:(NSString *)xid andUser_type:(NSInteger )user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
@end
