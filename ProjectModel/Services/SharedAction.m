    //
//  LoginViewOperation.m
//  Club
//
//  Created by dongway on 14-8-10.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "SharedAction.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "JSONModelLib.h"
#import "NSString+MT.h"
#import "BalanceModel.h"
#import "Status.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation SharedAction

+(void)presentLoginViewControllerInViewController:(UIViewController<LoginViewControllerDelegate> *)viewController{
    SharedData *sharedData = [SharedData sharedInstance];
    sharedData.loginStatus = @"NO";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    UINavigationController *userNavigationController = [[UINavigationController alloc] init];
    userNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
    LoginViewController *loginViewController = userNavigationController.viewControllers.firstObject;
    loginViewController.delegate = (id)viewController.tabBarController;
    [viewController presentViewController:userNavigationController animated:YES completion:nil];
}

//上传一张图片
+(void)callAPI:(NSString *)url parameters:(NSMutableDictionary *)parameters name:(NSString *)name image:(UIImage *)image withCompletion:(completion) completed{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [SVProgressHUD show];
    AFHTTPRequestOperation *op = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        //这里的name是服务器接收图片的字段。
        if (imageData) {
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@.jpg",name] mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SharedAction operationAfterSucccessActionWithOperation:operation andResponseObject:responseObject andUrl:url andParameters:parameters withCompletion:completed];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SharedAction operationAfterFailActionWithUrl:url andPatameters:parameters andError:error withCompletion:completed];
    }];
    [op start];
}
//上传多张图片
+(void)call1API:(NSString *)url parameters:(NSDictionary *)parameters name:(NSString *)name imageArray:(NSArray *)imageArray withCompletion:(completion) completed{
    [SVProgressHUD show];
    //    NSLog(@"%@",imageArray);
    NSMutableArray *imgs = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.greenwh.com"]];
    for (int i=0; i<imageArray.count-1; i++) {
        NSData *imageData1 = UIImageJPEGRepresentation(imageArray[i], 0.5);
        [imgs addObject:imageData1];
    }
    AFHTTPRequestOperation *op = [manager POST:Lifecircle_info_URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        //这里的name是服务器接收图片的字段。
        for (int i=0; i<imgs.count; i++) {
            [formData appendPartWithFileData:imgs[i] name:[NSString stringWithFormat:@"picture[%d]",i] fileName:[NSString stringWithFormat:@"photo%d.jpg",i] mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SharedAction operationAfterSucccessActionWithOperation:operation andResponseObject:responseObject andUrl:url andParameters:parameters withCompletion:completed];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SharedAction operationAfterFailActionWithUrl:url andPatameters:parameters andError:error withCompletion:completed];
    }];
    [op start];
}


+(void)operationAfterSucccessActionWithOperation:(AFHTTPRequestOperation *)operation andResponseObject:(id)responseObject andUrl:(NSString *)url andParameters:(NSDictionary *)parameters withCompletion:(completion) completed{
    NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
    [self logUrl:url parameters:parameters];
    NSNumber *status = responseObject[@"status"];
    NSString *error = responseObject[@"error"];
    NSLog(@"status = %@", status);
    if (![status isEqual:@2]) {
        [SVProgressHUD showErrorWithStatus:error];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"操作成功"];
        NSDictionary *dict = responseObject[@"info"];
        completed(YES, dict);
    }
}

+(void)operationAfterFailActionWithUrl:(NSString *)url andPatameters:(NSDictionary *)parameters andError:(NSError *)error withCompletion:(completion) completed{
    [self logUrl:url parameters:parameters];
    NSLog(@"Error: %@", error);
    completed(NO, nil);
    [SVProgressHUD dismiss];
}

+(void) logUrl:(NSString *)url parameters:(NSDictionary *)parameters {
    NSString *fullUrl = [NSString stringWithFormat:@"%@", url];
    
    int index = 0;
    for (NSString *key in parameters) {
        if (index == 0) {
            fullUrl = [NSString stringWithFormat:@"%@%@", fullUrl, @"?"];
        } else {
            fullUrl = [NSString stringWithFormat:@"%@%@", fullUrl, @"&"];
        }
        fullUrl = [NSString stringWithFormat:@"%@%@=%@", fullUrl, key, parameters[key]];
        index ++;
    }
    NSLog(@"*** url ***: %@", fullUrl);
}


+(void)setUMessageTagsWithUser:(UserInfo *)user{
//    [UMessage removeAllTags:^(NSSet *responseTags, NSInteger remain, NSError *error) {
//        if (error) {
//            NSLog(@"responseTags=%@  remain=%ld  error=%@",responseTags,(long)remain,error);
//        }else{
//            NSArray *tags = [NSArray arrayWithObjects:user.loginname,user.nickname,user.realname,user.mobile,user.iccard,user.city,user.sname,user.address,user.version_name,[NSString stringWithFormat:@"%f",user.amount_red],[NSString stringWithFormat:@"%f",user.amount],[NSString stringWithFormat:@"%ld",(long)user.mid],[NSString stringWithFormat:@"%ld",(long)user.sid], nil];
//            [UMessage addTag:tags response:^(NSSet *responseTags, NSInteger remain, NSError *error) {
//                if (error) {
//                    NSLog(@"responseTags=%@  remain=%ld  error=%@",responseTags,(long)remain,error);
//                }
//            }];
//        }
//    }];
}
+(void)show
{
    [SVProgressHUD show];
}
+(void)dismiss
{
    [SVProgressHUD dismiss];
}
+(void)showError
{
    [SVProgressHUD showErrorWithStatus:@"两次输入密码不相同"];
    
}
+(void)showErrorDataError
{
    [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    
}
+(void)showErrorInput
{
    [SVProgressHUD showErrorWithStatus:@"输入不能为空"];
}
+(void)showErrorNoData
{
    [SVProgressHUD showErrorWithStatus:@"当前没有数据"];
}
+(void)showErrorNoMoreData
{
    [SVProgressHUD showErrorWithStatus:@"没有更多的数据"];
}

//下面的alertview的tag 1是余额不足2是无会员卡 4是密码错误
+(void)showErrorWithStatus:(NSInteger)status andError:(NSString *)error witViewController:(UIViewController *)viewController{
     UIAlertView *alertView;
    switch (status) {
        case 2:
            [SVProgressHUD dismiss];
            break;
        case 1:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case 801:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  802:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  803:
            alertView = [[UIAlertView alloc]initWithTitle:@"余额不足" message:@"请到小区所在生活馆及时充值" delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"现在去充值", nil];
            alertView.tag=1;
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            [alertView show];
            [SVProgressHUD dismiss];
            break;
        case  804:
            alertView= [[UIAlertView alloc]initWithTitle:@"无会员卡" message:@"请到小区所在生活馆购买会员卡" delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag =2;
            alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alertView show];
             [SVProgressHUD dismiss];
            break;
        case  805:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  806:
            alertView = [[UIAlertView alloc]initWithTitle:@"密码错误" message:@"支付密码错误请重新输入" delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag=4;
            alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alertView show];
             [SVProgressHUD dismiss];
            break;
        case  807:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  808:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  809:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  810:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  811:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  820:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  821:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  822:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  823:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  824:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  825:
            alertView = [[UIAlertView alloc]initWithTitle:@"您的账号在其他设备上登录" message:@"是否要重新登录" delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag=5;
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            [alertView show];
            [SVProgressHUD dismiss];
        break;
        case  826:
            [SVProgressHUD showErrorWithStatus:error];
            break;
        case  827:
            alertView = [[UIAlertView alloc]initWithTitle:@"需要登录以后才能使用该功能" message:@"是否要去登录" delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag=6;
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            [alertView show];
            [SVProgressHUD dismiss];
            break;
        default:
            [SVProgressHUD showErrorWithStatus:error];
            break;
    }
}

//notifyTime是HH:mm:ss格式  如：19:29:00
+(void)setLocalNotifyWithAlertBody:(NSString *)alertBody andType:(NSString *)type andFireDate:(NSString *)notifyTime{
    UIApplication *app;
    app= [UIApplication sharedApplication];
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    //设置推送时间
    noti.fireDate = [SharedAction notifyTime:notifyTime];
    //设置时区
    noti.timeZone = [NSTimeZone defaultTimeZone];
    //设置重复间隔
    noti.repeatInterval = NSCalendarUnitDay;
    //推送声音
    noti.soundName = UILocalNotificationDefaultSoundName;
    //内容
    noti.alertBody = alertBody;
    //显示在icon上的红色圈中的数子
    noti.applicationIconBadgeNumber = 1;
    //设置userinfo 方便在之后需要撤销的时候使用
    NSDictionary *infoDic = [NSDictionary dictionaryWithObject:type forKey:@"type"];
    noti.userInfo = infoDic;
    NSLog(@"noti.userInfo:%@",noti.userInfo);
    //获取本地推送数组
    NSArray *localArr;
    localArr = [app scheduledLocalNotifications];
    if (localArr) {
        for (int i=0;i<localArr.count;i++) {
            UILocalNotification *noti = localArr[i];
            NSLog(@"UILocalNotification[%d].userInfo:%@  noti.fireDate:%@",i,noti.userInfo,[NSString dateStringFromDate0:noti.fireDate]);
        }
    }
    //添加推送到uiapplication
    [app scheduleLocalNotification:noti];
    NSLog(@"alertBody:%@,type:%@,notifyTime:%@",alertBody,type,notifyTime);
}

//若time ealier now 则设置notifyTime==time；若time later now ，则设置notifyTime = time+one day；
+(NSDate *)notifyTime:(NSString *)time{
    NSDate *notifyTime = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
//    NSString *dateString = [NSString stringWithFormat:@"%@ %@",strDate,time];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:time];
    if ([[date laterDate:[NSDate date]] isEqual:date]) {
        notifyTime = date;
    }else{
        NSTimeInterval secondsPerDay = 24*60*60;
        notifyTime = [date dateByAddingTimeInterval:secondsPerDay];
    }
    NSLog(@"设置本地推送时间:%@",[dateFormatter stringFromDate:notifyTime]);
    return date;
}
//对比当前时间是不是在所需设置的时间之前
+(BOOL)notifyTime2:(NSString *)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:time];
    if ([[date laterDate:[NSDate date]] isEqual:date]) {
        return NO;
    }else{
        return YES;
    }
}

+(void)removeLocalPushNotificationWithType:(NSString *)type
{
    UIApplication* app=[UIApplication sharedApplication];
    //获取当前应用所有的通知
    NSArray* localNotifications=[app scheduledLocalNotifications];
    if (localNotifications) {
        for (UILocalNotification* notification in localNotifications) {
            NSDictionary* dic=notification.userInfo;
            if (dic) {
                NSString* key=[dic objectForKey:@"type"];
                if ([key isEqualToString:type]) {
                    //取消推送 （指定一个取消）
                    [app cancelLocalNotification:notification];
                    break;
                }
            }
        }
    }
}
+(void)shareWithTitle:(NSString *)title andDesinationUrl:(NSString *)url Text:(NSString *)text andImageUrl:(NSString *)imgUrl InViewController:(UIViewController *)viewController{
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        UIImage *img = nil;
        if ([imgUrl hasPrefix:@"http"]) {
            img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        }else{
            img = [UIImage imageNamed:imgUrl];
        }
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.qqData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
            [UMSocialData defaultData].extConfig.qqData.title = title;
            [UMSocialData defaultData].extConfig.qzoneData.title = title;
            [UMSocialSnsService presentSnsIconSheetView:viewController
                                                 appKey:UMengKEY
                                              shareText:text
                                             shareImage:img
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                               delegate:(id)viewController];
            [SVProgressHUD dismiss];
        });
    });
}
+(void)loginAggane
{
    SharedData *sharedData = [SharedData sharedInstance];
    NSString *name = sharedData.loginname;
    NSString *password = sharedData.password;
    NSString *urlString = [NSString stringWithFormat:Base_Member_Login_URL,name,password];
    [SVProgressHUD showWithStatus:@"正在加载用户信息"];
    [Member_Login getModelFromURLWithString:urlString completion:^(Member_Login *model,JSONModelError *error){
        if (model.status==2) {
            sharedData.user=model.info;
            sharedData.loginStatus=@"YES";
            [SharedAction setUMessageTagsWithUser:model.info];
        }else{
            [SVProgressHUD showErrorWithStatus:model.error];
        }
        NSLog(@"%@",urlString);
        [SVProgressHUD showSuccessWithStatus:@"登录成功完成"];
   }];
}
+(void)commonActionWithUrl:(NSString *)url andStatus:(NSInteger)status andError:(NSString *)error andJSONModelError:(JSONModelError *)jsonError andObject:(id)object withDone:(doneWithObject)done{
    NSLog(@"status=%ld url=%@ message=%@",(long)status,url,error);
    if (!jsonError) {
        if (status==2||status==808) {
            done(object);
            if (status==2) {
                [SVProgressHUD dismiss];
            }else{
             [SVProgressHUD showSuccessWithStatus:error];
            }
        }else{
            if (error==nil||[error isEqualToString:@""])
            {
                [SVProgressHUD dismiss];
            }else{
                [SVProgressHUD showErrorWithStatus:error];
            }
        }
    }else{
        NSLog(@"%@",jsonError);
    }
}
+(void)commonActionWithUrl:(NSString *)url andStatus:(NSInteger)status andError:(NSString *)error andJSONModelError:(JSONModelError *)jsonError andObject:(id)object withDoneAndStatus:(doneWithObjectAndStatus)done{
    NSLog(@"status=%ld url=%@ message=%@",(long)status,url,error);
    if (!jsonError) {
        done((int)status,object);
    }else{
        NSLog(@"%@",jsonError);
    }
}

+(void)commonActionWithUrl:(NSString *)url andStatus:(NSInteger)status andError:(NSString *)error andJSONModelError:(JSONModelError *)jsonError andObject:(id)object inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSLog(@"status=%ld url=%@ message=%@",(long)status,url,error);
    if (!jsonError) {
        if (status==808||status==806) {
            done(object);
            [SVProgressHUD showSuccessWithStatus:error];
        }else if(status==2){
            done(object);
            [SVProgressHUD dismiss];
        }else{
            if (error==nil||[error isEqualToString:@""])
            {
                [SVProgressHUD dismiss];
            }else{
                [SharedAction showErrorWithStatus:status andError:error witViewController:tabBarController];
            }
        }
    }else{
        NSLog(@"%@",jsonError);
    }
}
//各种余额话费积分 
+(void)baseBalanceWithToken:(NSString *)token andUser_type:(NSInteger)user_type withTabBarViewController:(UITabBarController*)tabBarController doneObject:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:Base_Balance_URL,token,user_type];
    [BalanceModel getModelFromURLWithString:urlString completion:^(BalanceModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
+(void)setupRefreshWithTableView:(UITableView *)tableview toTarget:(UIViewController *)target
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [tableview addHeaderWithTarget:target action:@selector(headerRereshing)];
    [tableview headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [tableview addFooterWithTarget:target action:@selector(footerRereshing)];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    tableview.headerPullToRefreshText = @"下拉可以刷新了";
    tableview.headerReleaseToRefreshText = @"松开马上刷新了";
    tableview.headerRefreshingText = @"正在帮你刷新中";
    tableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    tableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    tableview.footerRefreshingText = @"正在帮你加载中";
}

-(void)headerRereshing{
}
-(void)footerRereshing{
}

//指纹支付
+(void)fingerPayWithDone:(done)done{
    LAContext *myContext = [[LAContext alloc] init];
    //        myContext.localizedFallbackTitle = @"";//设置为nil，则不会出现“输入密码”
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"使用指纹支付";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [SVProgressHUD show];
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL succes, NSError *error) {
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if (succes) {
                                        done(succes,nil);
                                    } else {
                                        
                                        switch (error.code) {
                                            case LAErrorAuthenticationFailed:
                                                [SVProgressHUD showErrorWithStatus:@"支付失败"];
                                                break;
                                                
                                            case LAErrorUserCancel:
                                                [SVProgressHUD showErrorWithStatus:@"支付取消"];
                                                break;
                                            case kLAErrorUserFallback:
                                                done(succes,nil);
                                                break;
                                            default:
                                                [SVProgressHUD showErrorWithStatus:@"touch ID 尚未设置"];
                                                break;
                                        }
                                        [SVProgressHUD dismiss];
                                    }
                                });
                            }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"本设备不支持指纹识别"];
    }

}

#pragma UMSocialUIDelegate
//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
    }else{
        [SVProgressHUD showErrorWithStatus:response.message];
    }
}

/*
 1，设置login status 为登录状态
 2，在当前viewcontroller loadData
 注意：loginSuccessAction方法的实现在viewcontroller里，这里的loginSuccessAction是不会被触发的
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
+(void)confirmPssswordWithToken:(NSString *)token andUser_type:(NSInteger )user_type andType:(NSString *)type andPassword:(NSString *)password inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Confirm_Psssword,password,type,token,user_type];
    [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
        if (!error) {
            if (model.status==806) {
                done(model);
                [SVProgressHUD showSuccessWithStatus:model.error];
            }else if(model.status==2){
                done(model);
                [SVProgressHUD dismiss];
            }
        }else{
            NSLog(@"%@",error);
        }

    } ];

}
/*
 数量减1
 */
+(NSString *)reduceNumber:(UILabel *)countLabel{
    int currentCount = [countLabel.text intValue];
    if (currentCount>0) {
        currentCount--;
    }
    return [NSString stringWithFormat:@"%d",currentCount];
}

/*
 数量＋1
 */
+(NSString *)addNumber:(UILabel *)countLabel{
    int currentCount = [countLabel.text intValue];
    if (currentCount<20) {
        currentCount++;
    }
    return [NSString stringWithFormat:@"%d",currentCount];
}
@end
