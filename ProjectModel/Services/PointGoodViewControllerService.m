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

-(void)LoadDataInPointGoodViewController:(PointGoodViewController *)viewController
{
    

    
}
-(void)addOderINPointGoodWithToken:(NSString *)token andUser_type:(NSInteger )user_type andGId:(NSInteger )gid andNus:(NSString *)nums andPassword:(NSString *)passwd inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done
{
     NSString *password = [MyMD5 md5:passwd];
    NSString *urlString = [NSString stringWithFormat:PointSignUp,token,user_type,gid,nums,password];
    [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model inTabBarController:tabBarController withDone:done];
    }];
}
-(void)addOderInPointGoodViewController:(PointGoodViewController *)viewController WithPassword:(NSString *)password AndSum:(NSInteger )sum
{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *gid = [viewController.dict valueForKey:@"gid"];
    NSString *nums = [NSString stringWithFormat:@"%ld",(long)sum];
    NSString *passwd = [MyMD5 md5:password];
    NSString *urlString = [NSString stringWithFormat:PointSignUp,user.token,user.user_type,gid,nums,passwd];
    NSLog(@"%@",urlString);
    Status *status = [[Status alloc] initFromURLWithString:urlString completion:^(Status *model,NSError *error){
        NSLog(@"----%ld",(long)status);
        if (model.status==2) {
            [SVProgressHUD showSuccessWithStatus:@"积分兑换成功"];
            NSInteger price = [[viewController.dict valueForKey:@"point"] integerValue]*sum;
            user.point = user.point-price;
        }
        [SVProgressHUD showErrorWithStatus:model.error];
    }];
    
}
@end
