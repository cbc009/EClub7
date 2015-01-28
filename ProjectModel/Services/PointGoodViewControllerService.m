//
//  PointGoodViewControllerService.m
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PointGoodViewControllerService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import <UIImageView+WebCache.h>
#import "SharedData.h"
#import "Member_Login.h"
#import "MyMD5.h"
#import "JSONModelLib.h"
#import "Status.h"
#import "SVProgressHUD.h"
@implementation PointGoodViewControllerService


-(void)addOderINPointGoodWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGId:(NSInteger )gid andNus:(NSString *)nums andPassword:(NSString *)passwd inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done
{
     NSString *password = [MyMD5 md5:passwd];
    NSString *urlString = [NSString stringWithFormat:PointSignUp,token,user_type,gid,nums,password];
    [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model inTabBarController:tabBarController withDone:done];
    }];
}

@end
