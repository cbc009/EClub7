//
//  SomeoneContentService.m
//  Club
//
//  Created by MartinLi on 15-2-3.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "SomeoneContentService.h"
#import "SomeoneContent.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
@implementation SomeoneContentService
-(void)lifecircleLifeInfoWithToken:(NSString *)token andXid:(NSString *)xid andUser_type:(NSInteger )user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:Lifecircle_Life_Info_URL,xid,token,user_type];
    [SomeoneContent getModelFromURLWithString:urlString completion:^(SomeoneContent *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}

@end

