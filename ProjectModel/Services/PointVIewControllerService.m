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
#import "Login.h"
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
-(void)loadDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPage:(NSString *)page OnViewCOntroller:(PointViewController *)viewController
{
    

    NSString *urlString = [NSString stringWithFormat:PointGoodslist,token,user_type,page];
    NSLog(@"%@",urlString);
    [PointGoodsModel getModelFromURLWithString:urlString completion:^(PointGoodsModel *model,JSONModelError *error){
        if (model.status==2) {
            viewController.datas = model.info.goods;
            [viewController.collectionview reloadData];
            if (model.info.goods==nil||model.info.goods.count<1) {
                [SVProgressHUD showErrorWithStatus:model.error];
            }else{
                NSLog(@"%@",model.error);
                [SVProgressHUD dismiss];
            }
        }else{
            NSLog(@"%@",model.error);
            [SVProgressHUD showErrorWithStatus:model.error];
        }
    }];
}
-(void)loadMoreDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type AndPage:(NSString *)page OnViewCOntroller:(PointViewController *)viewController
{
    NSString *urlString = [NSString stringWithFormat:PointGoodslist,token,user_type,page];
    [PointGoodsModel getModelFromURLWithString:urlString completion:^(PointGoodsModel *model,JSONModelError *error){
        if (model.status==2) {
            [viewController.datas addObjectsFromArray: model.info.goods];
            [viewController.collectionview reloadData];
            if (model.info.goods==nil||model.info.goods.count<1) {
                [SVProgressHUD showErrorWithStatus:@"暂时没有商品兑换"];
            }else{
                [SVProgressHUD dismiss];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model.error];
        }
        
    }];

}

@end
