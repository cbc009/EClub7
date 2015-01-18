//
//  FeedbackService.m
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "FeedbackService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "SVProgressHUD.h"
#import "Status.h"
#import "JSONModelLib.h"
#import "SharedAction.h"
@implementation FeedbackService
-(void)submitWithContent:(NSString *)content{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *user_type = [NSString stringWithFormat:@"%ld",(long)user.user_type];
       NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:user.token,user_type,content, nil] forKeys:[NSArray arrayWithObjects:@"token",@"user_type",content, nil]];
    NSString *urlString = FeedBackURL;
    if (content==nil||content.length<5) {
        [SVProgressHUD showErrorWithStatus:@"字数不够"];
        return;
    }
    [SVProgressHUD show];
    NSLog(@"----%@ %@",urlString,dict);
    [JSONHTTPClient postJSONFromURLWithString:urlString params:dict completion:^(id object, JSONModelError *error) {
        NSString *error1 = (NSString *)[object objectForKey:@"error"];
        if (error1==nil) {
            NSNumber *sta = (NSNumber*)[object objectForKey:@"status"];
            NSInteger status = [sta integerValue];
            NSLog(@"%ld",(long)status);
            [SharedAction showErrorWithStatus:status];
        }else{
            NSNumber *sta = (NSNumber*)[object objectForKey:@"status"];
            NSInteger status = [sta integerValue];

            NSLog(@"%ld",(long)status);

            [SVProgressHUD showErrorWithStatus:error1];
        }
        
    }];
}
@end
