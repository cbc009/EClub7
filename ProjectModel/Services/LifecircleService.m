//
//  LifecircleService.m
//  Club
//
//  Created by MartinLi on 15-1-12.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "LifecircleService.h"
#import "Status.h"
#import <JSONModelLib.h>
@implementation LifecircleService

-(void)lifecircleWitkToken:(NSString *)token andUser_Type:(NSInteger )user_type withContent:(NSString *)content andImageArray:(NSArray *)imageArray withTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done
{
    NSString *user_type1 =  [NSString stringWithFormat: @"%ld",(long)user_type];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:token, @"token",user_type1,@"user_type",content,@"content",nil];
    [SVProgressHUD show];
    [SharedAction call1API:Lifecircle_info_URL parameters:parameters name:@"picture" imageArray:imageArray withCompletion:^(BOOL complete,NSDictionary *info){
        if (complete) {
            done(info);
        }
    }];
}
-(void)lifecircleLifedeleteWithToken:(NSString *)token andUser_type:(NSInteger )user_type andXid:(NSString *)xid withDone:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Lifecircle_Life_delete_URL,xid,token,user_type];
    [SVProgressHUD show];
    [Status getModelFromURLWithString:urlString completion:^(Status *object,JSONModelError*error){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object withDone:done];
    }];
}
-(void)lifecircleLifeCommentWithToken:(NSString *)token andUser_type:(NSInteger )user_type andContent:(NSString *)content andXid:(NSString *)xid withTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done
{
    NSString *user_type1 = [NSString stringWithFormat:@"%ld",(long)user_type];
    NSDictionary *dicet= [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",user_type1,@"user_type",xid,@"xid",content,@"content",nil];
    [SVProgressHUD show];
    [JSONHTTPClient postJSONFromURLWithString:Lifecircle_Comment_info_URL params:dicet completion:^(id object, JSONModelError *error) {
        NSNumber *sta = (NSNumber*)[object objectForKey:@"status"];
        NSString *error1 = (NSString *)[object objectForKey:@"error"];
          NSInteger status = [sta integerValue];
        [SharedAction commonActionWithUrl:Lifecircle_Comment_info_URL andStatus:status andError:error1 andJSONModelError:error andObject:object inTabBarController:tabBarController withDone:done];
    }];
}
@end
