//
//  PointGoodViewControllerService.m
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PointGoodViewControllerService.h"
#import "SharedData.h"
#import "Login.h"
#import <UIImageView+WebCache.h>
#import "SharedData.h"
#import "Login.h"
#import "MyMD5.h"
#import "JSONModelLib.h"
#import "Status.h"
#import "SVProgressHUD.h"
@implementation PointGoodViewControllerService

-(void)LoadDataInPointGoodViewController:(PointGoodViewController *)viewController
{
    viewController.title = [viewController.dict valueForKey:@"name"];
    [viewController.goodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,[viewController.dict valueForKey:@"bigpicture"]]] placeholderImage:[UIImage imageNamed:@"e"]];
    viewController.pasPrize.text = [NSString stringWithFormat:@"%@/%@",[viewController.dict valueForKey:@"price"],[viewController.dict valueForKey:@"unit"]];
    viewController.vipPrize.text = [NSString stringWithFormat:@"%@/%@",[viewController.dict valueForKey:@"price"],[viewController.dict valueForKey:@"unit"]];
    viewController.ePrize.text = [NSString stringWithFormat:@"%@/份",[viewController.dict valueForKey:@"point"]];;

    
}
-(void)addOderInPointGoodViewController:(PointGoodViewController *)viewController WithPassword:(NSString *)password AndSum:(NSInteger )sum
{
    NSLog(@"%@,%ld",password,(long)sum);
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
