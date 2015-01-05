//
//  ItemDetailService.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ItemDetailService.h"
#import "PurchaseCarItemsViewController.h"
#import "SVProgressHUD.h"
#import "SharedData.h"
#import "Login.h"
#import "JSONModelLib.h"
#import "Cart.h"
#import "Status.h"
#import "SharedAction.h"
#import "Search_goods.h"
#import "WebViewController.h"
@implementation ItemDetailService

/*
 数量减1
 */
-(NSString *)reduceNumber:(UILabel *)countLabel{
    int currentCount = [countLabel.text intValue];
    if (currentCount>0) {
        currentCount--;
    }
    return [NSString stringWithFormat:@"%d",currentCount];
}

/*
 数量＋1
 */
-(NSString *)addNumber:(UILabel *)countLabel{
    int currentCount = [countLabel.text intValue];
    if (currentCount<20) {
        currentCount++;
    }
    return [NSString stringWithFormat:@"%d",currentCount];
}

/*
 立即购买
 */
-(void)presentPurchaseCarViewControllerOnViewController:(ItemDetailViewController *)viewController andItemCount:(NSString *)count{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *urlString1;
    Type_goods_good *goodModel = viewController.goodModel;
        urlString1 = [NSString stringWithFormat:InCartURL,user.token,goodModel.gid,user.user_type,count];
    NSLog(@"%@ ",urlString1);
    [SVProgressHUD show];
    [Status getModelFromURLWithString:urlString1 completion:^(Status *object,JSONModelError *error){
        if (object.status == 2) {
            PurchaseCarItemsViewController *target = [viewController.storyboard instantiateViewControllerWithIdentifier:@"PurchaseCarItemsViewController"];
            [viewController.navigationController pushViewController:target animated:YES];
        }else{
            [SharedAction showErrorWithStatus:object.status witViewController:viewController];
            NSLog(@"%@",error);
        }
    }];
}


/*
 加入购物车
 */
-(void)addToPurchaseCarWithGid:(NSString *)gid andNum:(NSString *)num{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    [SVProgressHUD show];
     NSString *urlString = [NSString stringWithFormat:InCartURL,user.token,gid,user.user_type,num];
    [Status getModelFromURLWithString:urlString completion:^(Status *object,JSONModelError *error){
        if (object.status == 2) {
            [SVProgressHUD showSuccessWithStatus:@"加入购物车成功"];
        }else{
            [SharedAction showErrorWithStatus:object.status];
            NSLog(@"%@",error);
        }
    }];
}

@end
