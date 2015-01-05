//
//  Index2.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index2Service.h"
#import "WebViewController.h"
#import "SecondeChangeViewController.h"
#import "MyneighborViewController.h"
#import "LiveViewController.h"
@implementation Index2Service
/*
 快递查询
 
 */
-(void)presentEmsViewControllerOnViewController:(UIViewController *)viewController{
    WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    target.urlString = @"http://m.kuaidi100.com/";
    target.title = @"快递查询";
   
    target.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:target animated:YES];
}
/*
 水煤电缴费
 */

-(void)presentAlipayViewControllerOnViewController:(UIViewController *)viewController{
    WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    target.urlString = @"http://fun.alipay.com/exprodJF/jiaofeiBD.htm";
    target.title =@"水电缴费";
    target.view.frame = CGRectMake(0, 66, DeviceFrame.size.width, DeviceFrame.size.height-100);
//    target.view.frame = CGRectMake(0,90, DeviceFrame.size.width, DeviceFrame.size.height-90);
    target.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:target animated:YES];
}
//积分兑换
-(void)presentSecondeChangeViewControllerOnViewController:(UIViewController *)viewController{
    NSLog(@"dd");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
    SecondeChangeViewController *searchangeViewController = [storyboard instantiateViewControllerWithIdentifier:@"SecondeChangeViewController"];
    searchangeViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:searchangeViewController animated:YES];
}
//我的邻居
-(void)presentMyneighborViewControllerOnViewController:(UIViewController *)viewController{
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
    MyneighborViewController *myneighborViewController = [storyboard instantiateViewControllerWithIdentifier:@"MyneighborViewController"];
    myneighborViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:myneighborViewController animated:YES];
}
//生活圈
-(void)presentLiveViewControllerOnViewController:(UIViewController *)viewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
    LiveViewController *liveViewController = [storyboard instantiateViewControllerWithIdentifier:@"LiveViewController"];
    liveViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:liveViewController animated:YES];
}
@end
