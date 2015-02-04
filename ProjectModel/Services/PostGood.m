//
//  PostGood.m
//  Club
//
//  Created by MartinLi on 14-12-21.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PostGood.h"
#import "JSONModelLib.h"
#import "Status.h"
#import "SVProgressHUD.h"
#import "SharedAction.h"
#import "MLMutiImagesChoosenViewController.h"
#import "JSONModelLib.h"
@implementation PostGood
-(void)postGoodWithmid:(NSInteger )mid andSid:(NSInteger )sid andTitle:(NSString *)title andContent:(NSString *)content andDegree:(NSString *)degree andPrice:(NSString *)price andName:(NSString *)name andMobile:(NSString *)mobile andImageArray:(NSArray *)imageArray onViewController:(PostViewController *)viewcontroller
{
    
//    NSString *mid1 =  [NSString stringWithFormat: @"%ld",(long)mid];
//    NSString *sid1 =  [NSString stringWithFormat: @"%ld",(long)sid];
//    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:mid1, @"mid",sid1,@"sid",title,@"title",content,@"content",degree,@"degree",price,@"price",name,@"name",mobile,@"mobile",nil];
//    [SharedAction call1API:PostSecondChangeURL parameters:parameters name:@"picture" imageArray:imageArray inTabBarController:tabBarController withCompletion:^(BOOL complete,NSDictionary *info){
//        if (complete) {
//            finished(info);
//            NSLog(@"%@",info);
//        }
//
//        }];
}
-(void)postGoodWithmid:(NSInteger )mid andSid:(NSInteger )sid andTitle:(NSString *)title andContent:(NSString *)content andDegree:(NSString *)degree andPrice:(NSString *)price andName:(NSString *)name andMobile:(NSString *)mobile onViewController:(PostbuyViewController *)viewcontroller
{
    NSString *mid1 =  [NSString stringWithFormat: @"%ld",(long)mid];
    NSString *sid1 =  [NSString stringWithFormat: @"%ld",(long)sid];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:mid1, @"mid",sid1,@"sid",title,@"title",content,@"content",degree,@"degree",price,@"price",name,@"name",mobile,@"mobile",nil];

    [JSONHTTPClient postJSONFromURLWithString:PostBuySecondChangeURL params:parameters completion:^(id object, JSONModelError *error) {
        NSNumber *status = object[@"status"];
        NSString *error1 = object[@"error"];
        if ([status isEqual:[NSNumber numberWithInt:2]]) {

            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
        }else{
            [SharedAction showErrorWithStatus:[status integerValue] andError:error1 witViewController:viewcontroller];
        }
        
    }];

    
}
@end
