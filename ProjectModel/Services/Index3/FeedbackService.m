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
#import "FeedbackModel.h"
@implementation FeedbackService
-(void)submitWithContent:(NSString *)content withToken:(NSString *)token andUser_type:(NSInteger )user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *user_type1 = [NSString stringWithFormat:@"%ld",(long)user_type];
       NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:token,user_type1,content, nil] forKeys:[NSArray arrayWithObjects:@"token",@"user_type",@"content", nil]];
    NSString *urlString = FeedBackURL;
    if (content==nil||content.length<5) {
        [SVProgressHUD showErrorWithStatus:@"字数不够"];
        return;
    }
    [SVProgressHUD show];
    [JSONHTTPClient postJSONFromURLWithString:urlString params:dict completion:^(id object, JSONModelError *error) {
        NSString *error1 = (NSString *)[object objectForKey:@"error"];
            NSNumber *sta = (NSNumber*)[object objectForKey:@"status"];
            NSInteger status = [sta integerValue];
        [SharedAction commonActionWithUrl:urlString andStatus:status andError:error1 andJSONModelError:error andObject:object inTabBarController:tabBarController withDone:done];
    }];
}
-(void)baseMyadviceWithToken:(NSString *)token andUser_Type:(NSInteger)user_typ intabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done{
    NSString *usrString = [NSString stringWithFormat:Base_Myadvice_URL,token,user_typ];
    [FeedbackModel getModelFromURLWithString:usrString completion:^(FeedbackModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:usrString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];


}
@end
