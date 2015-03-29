//
//  RemarkService.m
//  Club
//
//  Created by MartinLi on 15-3-29.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RemarkService.h"
#import "JSONModelLib.h"
#import "SVProgressHUD.h"
#import "Status.h"
@implementation RemarkService
-(void)seller_comment_releaseWuthType:(NSString *)type andSeller_id:(NSString *)seller_id andContent:(NSString *)content andPraise_nums:(NSString *)Praise_nums andComment_id:(NSString *)comment_id andOther_id:(NSString *)other_id andTotal_praises:(NSString *)total_praises andAttitude_praises:(NSString *)attitude_praises andNeat_praises:(NSString *)neat_praises andDescrip_praises:(NSString *)descrip_praises andToken:(NSString *)token andUser_type:(NSInteger )user_type inTabBarController:(UITabBarController *)tabBarCOntroller withDone:(doneWithObject)done{
    NSString *user_type1 = [NSString stringWithFormat:@"%ld",(long)user_type];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:type,seller_id,content,Praise_nums,comment_id,other_id,total_praises,attitude_praises, neat_praises,descrip_praises,token,user_type1,nil] forKeys:[NSArray arrayWithObjects:@"type",@"seller_id",@"content", @"praise_nums",@"comment_id",@"other_id",@"total_praises",@"attitude_praises",@"neat_praises",@"descrip_praises",@"token",@"user_type",nil]];
    NSString *urlString = Seller_Seller_Comment_ReleaseURL;
    [JSONHTTPClient postJSONFromURLWithString:urlString params:dict completion:^(id object, JSONModelError *error) {
        NSString *error1 = (NSString *)[object objectForKey:@"error"];
        NSNumber *sta = (NSNumber*)[object objectForKey:@"status"];
        NSInteger status = [sta integerValue];
        [SharedAction commonActionWithUrl:urlString andStatus:status andError:error1 andJSONModelError:error andObject:object inTabBarController:tabBarCOntroller withDone:done];
    }];
}
@end
