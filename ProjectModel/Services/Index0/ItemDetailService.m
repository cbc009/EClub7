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
#import "Member_Login.h"
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
-(void)presentPurchaseCarViewControllerWithToken:(NSString*)token andUser_type:(NSInteger )user_type andGid:(NSString *)gid andNums:(NSString *)nums inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:InCartURL,token,gid,user_type,nums];
    [SVProgressHUD show];
    [Status getModelFromURLWithString:urlString completion:^(Status *object,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object inTabBarController:tabBarController withDone:done];
        }];
}

/*
 加入购物车
 */
-(void)addToPurchaseCarWithGid:(NSString *)gid andNum:(NSString *)num inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    [SVProgressHUD show];
     NSString *urlString = [NSString stringWithFormat:InCartURL,user.token,gid,user.user_type,num];
    [Status getModelFromURLWithString:urlString completion:^(Status *object,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object inTabBarController:tabBarController withDone:done];
    }];
}

@end
