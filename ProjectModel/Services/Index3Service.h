//
//  Index3Service.h
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Index3ViewController.h"
@class MyWalletViewController;
@interface Index3Service : NSObject
-(void)presentUserDetailViewControllerOnViewController:(UIViewController *)viewController;
-(void)presentFeedBackViewControllerOnViewController:(UIViewController *)viewController;
-(void)presentQRCodeViewControllerOnViewController:(UIViewController *)viewController;
-(void)presentMyWalletViewControllerOnViewController:(UIViewController *)viewController;
-(void)presentMyOrderViewControllerOnViewController:(UIViewController *)viewController;
-(void)callWithPhoneNumber:(NSString *)phoneNumber InViewController:(Index3ViewController *)viewController;
-(void)presentAppViewControllerOnViewController:(UIViewController *)viewController;

@end
