//
//  PartnerListServise.h
//  Club
//
//  Created by MartinLi on 15-1-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartnerListServise : NSObject
-(void)partnerPartnerListWithToken:(NSString *)token andUer_type:(NSInteger )user_type andTabbarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)presentpartnerDetailwithToken:(NSString *)token andUser_type:(NSInteger )uesr_type andPartner_id:(NSString*)partner_id inViewControllerOnViewController:(UIViewController *)viewController;
@end
