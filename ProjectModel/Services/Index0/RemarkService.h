//
//  RemarkService.h
//  Club
//
//  Created by MartinLi on 15-3-29.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemarkService : NSObject
-(void)seller_comment_releaseWuthType:(NSString *)type andSeller_id:(NSString *)seller_id andContent:(NSString *)content andPraise_nums:(NSString *)Praise_nums andComment_id:(NSString *)comment_id andOther_id:(NSString *)other_id andTotal_praises:(NSString *)total_praises andAttitude_praises:(NSString *)attitude_praises andNeat_praises:(NSString *)neat_praises andDescrip_praises:(NSString *)descrip_praises andToken:(NSString *)token andUser_type:(NSInteger )user_type inTabBarController:(UITabBarController *)tabBarCOntroller withDone:(doneWithObject)done;
@end
