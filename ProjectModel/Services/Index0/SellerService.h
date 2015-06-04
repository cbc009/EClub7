//
//  SellerService.h
//  Club
//
//  Created by MartinLi on 15-3-28.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoopGoodsViewController.h"
#import "ShowDetailViewController.h"
#import "Seller_Seller_Goods.h"
@interface SellerService : NSObject
-(void)sellerSellerGood_typesWith:(NSString *)good_type andAgentId:(NSString *)agent_id andSeller_id:(NSString *)seller_id andLifehall_id:(NSString *)lifehall_id andPage:(NSString *)pageString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)publickSellerListWithTypeString:(NSString *)typeString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)publicSellerInfoWithAgent_id:(NSString *)agent_id anrTypeString:(NSString *)typeSting inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)sellerSellerCommentInfoWithSeller_id:(NSString *)seller_id andPageString:(NSString *)pageString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)changeBaiduApiWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude withDone:(doneWithObject)done;
-(void)sellerOrderReturnwithToken:(NSString *)token andUser_type:(NSInteger)user_type andOrder_id:(NSString *)order_id inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)sellerCountDownWithGoodsType:(NSString *)goode_type andGoodId:(NSString *)good_id inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)sellerInfoWithAgentid:(NSString*)agent_id andSeller_type:(NSString *)seller_type andSellerid:(NSString *)seller_id inRootTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)presentShoopGoodsViewControllerIn:(ShowDetailViewController*)viewController and:(Seller_Seller_Goods_arr_goods_info*)model;
@end
