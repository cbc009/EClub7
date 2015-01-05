//
//  GroupService.h
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupsViewController.h"
#import "GroupDetailViewController.h"

@interface GroupService : NSObject

-(void)addToGroupInViewController:(GroupDetailViewController *)viewController withPassword:(NSString *)password;
-(NSString *)toDetailTime:(NSInteger)seconds;
-(void)groupsGoodsfutureWithToken:(NSString*)token andUser_type:(NSInteger )user_type withDoneObject:(doneWithObject)done;
-(void)loadAdverPicFromUrl:(NSString *)url inViewController:(GroupsViewController *)viewController;
-(void)presentCreatePayViewControllerOnViewController:(UIViewController *)viewController;
@end
