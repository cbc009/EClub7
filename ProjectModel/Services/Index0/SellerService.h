//
//  SellerService.h
//  Club
//
//  Created by MartinLi on 15-3-28.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellerService : NSObject
-(void)sellerSellerGood_typesWith:(NSString *)good_type andSeller_id:(NSString *)seller_id andLifehall_id:(NSString *)lifehall_id andPage:(NSString *)pageString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)publickSellerListWithTypeString:(NSString *)typeString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)publicSellerInfoWithAgent_id:(NSString *)agent_id anrTypeString:(NSString *)typeSting inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)sellerSellerCommentInfoWithSeller_id:(NSString *)seller_id andPageString:(NSString *)pageString inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)changeBaiduApiWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude withDone:(doneWithObject)done;
@end
