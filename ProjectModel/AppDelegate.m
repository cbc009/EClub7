//
//  AppDelegate.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//  

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "SVProgressHUD.h"
#import "CreatePayViewController.h"
#import "CreatePayService.h"
#import "UMessage.h"
#import "UMFeedback.h"
#import "UMSocialWechatHandler.h"
#import <UMengSocial/UMSocialSnsService.h>
#import <UMengAnalytics/MobClick.h>
#import <UMengSocial/UMSocialData.h>
#import <UMSocialQQHandler.h>
#import "UMSocialSinaHandler.h"
#import <BmobSDK/Bmob.h>
#import "NSString+MT.h"
#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupUmengAnalyticsPlatform];
    [self setupSocialSharePlatform];
    [self setUMessageWithLaunchOptions:launchOptions];
    [Bmob registerWithAppKey:BmobAppID];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken=%@",deviceToken);
    [UMessage registerDeviceToken:deviceToken];
    NSLog(@"umeng message alias is: %@", [UMFeedback uuid]);
    [UMessage addAlias:[UMFeedback uuid] type:@"umeng_feedback" response:^(id responseObject, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
            NSLog(@"%@", responseObject);
        }
    }];
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接收到本地提醒 in app"
                                                    message:notification.alertBody
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    //这里，你就可以通过notification的useinfo，干一些你想做的事情了
    application.applicationIconBadgeNumber -= 1;
//    [[UIApplication sharedApplication] cancelLocalNotification:notification];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
    [UMFeedback didReceiveRemoteNotification:userInfo];
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    NSString *value = [userInfo objectForKey:@"key"];
    NSLog(@"userInfo=%@  alert=%@   value=%@",userInfo,alert,value);
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"url=%@   sourceApplication=%@",url,sourceApplication);
    //如果极简SDK不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSString *status = [resultDic objectForKey:@"resultStatus"];
            if ([status isEqualToString:@"9000"]) {
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                
                SharedData *sharedData = [SharedData sharedInstance];
                UserInfo *user = [sharedData user];
                user.amount = user.amount+sharedData.createPayPrice;
                NSLog(@"sharedData.createPayPrice:%f",sharedData.createPayPrice);
                UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                
                CreatePayService *service = [[CreatePayService alloc] init];
                [service pushToMyWalletViewControllerInTabBarController:tab];
                
                //存储到Bmob后台
                BmobObject *object = [BmobObject objectWithClassName:@"Recharge"];
                [object setObject:user.loginname forKey:@"loginname"];
                [object setObject:@"aliPay" forKey:@"payType"];
                [object setObject:[NSNumber numberWithFloat:sharedData.createPayPrice] forKey:@"price"];
                [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    //进行操作
                }];

            }else{
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
            }
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
           
            NSLog(@"reslut = %@",resultDic);
            NSString *status = [resultDic objectForKey:@"resultStatus"];
            if ([status isEqualToString:@"9000"]) {
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
            }
        }];
    }
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

-(void)setupUmengAnalyticsPlatform{
    [MobClick startWithAppkey:UMengKEY reportPolicy:BATCH channelId:nil];
}

-(void)setupSocialSharePlatform{
    [UMSocialData setAppKey:UMengKEY];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WeiXinAppID appSecret:WeiXinAppSecret url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppKEY url:@"http://www.umeng.com/social"];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

-(void)setUMessageWithLaunchOptions:(NSDictionary *)launchOptions{
    NSLog(@"launchOptions=%@",launchOptions);
    [UMFeedback setAppkey:UMengKEY];
    [UMessage startWithAppkey:UMengKEY launchOptions:launchOptions];
    
    if (IOS_8_OR_LATER) {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];

    } else {
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeSound |
         UIRemoteNotificationTypeAlert];
    }
    [UMessage setLogEnabled:NO];
    
    //关闭状态时点击反馈消息进入反馈页
    NSDictionary *notificationDict = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    [UMFeedback didReceiveRemoteNotification:notificationDict];
    
}



@end
