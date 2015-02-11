//
//  FinalConfirmService.h
//  Club
//
//  Created by dongway on 14-8-13.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectItemsTableViewController.h"
#import "CreatePayViewController.h"
@class FinalConfirmViewController;
@interface FinalConfirmService : NSObject
-(void)presentCreatePayViewControllerOnViewController:(UIViewController *)viewController;
-(void)showTimePickerViewOnView:(UIView *)superView withFrame:(CGRect)frame andDatas:(NSArray *)datas onTarget:(id<SelectedItemsTableViewControllerDelegate>)delegate withObject:(id)sender;

-(void)hideChildController:(UIViewController *)childController withObject:(id)object;

-(void)payMethod1:(UIButton *)sender inViewController:(FinalConfirmViewController *)viewController;
-(void)payMethod2:(UIButton *)sender inViewController:(FinalConfirmViewController *)viewController;
-(void)sendMethod1:(UIButton *)sender inViewController:(FinalConfirmViewController *)viewController;
-(void)sendMethod2:(UIButton *)sender inViewController:(FinalConfirmViewController *)viewController;
-(void)submitActionInViewController:(FinalConfirmViewController *)viewController;

-(void)submitDatas:(NSString *)datas andToken:(NSString *)token andUser_type:(NSInteger )user_type andPayType:(NSString *)payType sendType:(NSString *)sendType andSendid:(NSString *)sendid andAddress:(NSString *)address andMobile:(NSString *)mobile andMessage:(NSString *)message withPassword:(NSString *)password inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(void)loadDeliveryInfosWithToken:(NSString *)token anduser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done;
-(NSString *)finalItemsWithObjects:(NSArray *)datas;
-(NSString *)sendTypeInViewController:(FinalConfirmViewController *)viewController;
-(NSString *)payTypeInViewController:(FinalConfirmViewController *)viewController;
@end
