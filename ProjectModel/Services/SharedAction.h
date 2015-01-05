//
//  LoginViewOperation.h
//  Club
//
//  Created by dongway on 14-8-10.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"
#import "UMessage.h"
#import "Login.h"
#import <UMengSocial/UMSocialSnsService.h>
#import <UMengSocial/UMSocialSnsPlatformManager.h>

typedef void (^completion)(BOOL completed, NSDictionary *data);
typedef void (^finished)(NSDictionary *info);
typedef void (^doneWithObject)(id object);
typedef void (^doneWithObjectAndStatus)(int status,id object);
@interface SharedAction : NSObject<UMSocialUIDelegate>

/*
 1，在当前viewcontroller调出loginviewController
 2，给当前viewcontroller添加监听事件
 */

+(void)presentLoginViewControllerInViewController:(UIViewController *)viewController;
+(void)setUMessageTagsWithUser:(UserInfo *)user;
+(void)showErrorWithStatus:(NSInteger)status witViewController:(UIViewController *)viewController;
+(void)showErrorWithStatus:(NSInteger)status;
+(void)showError;
+(void)show;
+(void)dismiss;
+(void)showErrorInput;
+(void)showErrorDataError;
+(void)showErrorNoData;
+(void)showErrorNoMoreData;
+(void)shareWithTitle:(NSString *)title andDesinationUrl:(NSString *)url Text:(NSString *)text andImageUrl:(NSString *)imgUrl InViewController:(UIViewController *)viewController;
+(void)callAPI:(NSString *)url parameters:(NSMutableDictionary *)parameters name:(NSString *)name image:(UIImage *)image withCompletion:(completion) completed;
+(void)setLocalNotifyWithAlertBody:(NSString *)alertBody andType:(NSString *)type andFireDate:(NSString *)notifyTime;
+(void)call1API:(NSString *)url parameters:(NSDictionary *)parameters name:(NSString *)name imageArray:(NSArray *)imageArray withCompletion:(completion) completed;
+(void)commonActionWithUrl:(NSString *)url andStatus:(NSInteger)status andError:(NSString *)error andJSONModelError:(JSONModelError *)jsonError andObject:(id)object withDone:(doneWithObject)done;
+(void)setupRefreshWithTableView:(UITableView *)tableview toTarget:(UIViewController *)target;
+(void)commonActionWithUrl:(NSString *)url andStatus:(NSInteger)status andError:(NSString *)error andJSONModelError:(JSONModelError *)jsonError andObject:(id)object withDoneAndStatus:(doneWithObjectAndStatus)done;
+(void)loginAggane;
@end
