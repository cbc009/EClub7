//
//  PointVIewControllerService.m
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PointVIewControllerService.h"
#import "PointGoodViewController.h"
#import "PointGoodViewControllerService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "JSONModelLib.h"
#import "PointGoodsModel.h"
#import "SVProgressHUD.h"
@implementation PointVIewControllerService
-(void)presentPointGoodViewControllerWithDatas:(NSDictionary *)dic OnPointViewController:(PointViewController *)viewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    PointGoodViewController *pointGoodVIewController = [storyboard instantiateViewControllerWithIdentifier:@"PointGoodViewController"];
    pointGoodVIewController.hidesBottomBarWhenPushed = YES;
    pointGoodVIewController.dict = dic;
    [viewController.navigationController pushViewController:pointGoodVIewController animated:YES];
}
-(void)loadDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPage:(NSString *)page intabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:PointGoodslist,token,user_type,page];
    NSLog(@"%@",urlString);
    [PointGoodsModel getModelFromURLWithString:urlString completion:^(PointGoodsModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
        }];
}


@end
