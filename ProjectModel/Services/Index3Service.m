//
//  Index3Service.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index3Service.h"
#import "UserDetailViewController.h"
#import "FeedbackViewController.h"
#import "QRCodeViewController.h"
#import "MyWalletViewController.h"
#import "JSONModelLib.h"
#import "Amount.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "MyOrderViewController.h"
#import "AppViewController.h"
#import "SVProgressHUD.h"
@implementation Index3Service

/*
    用户详情
 */
-(void)presentUserDetailViewControllerOnViewController:(UIViewController *)viewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    UserDetailViewController *userDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
    userDetailViewController.hidesBottomBarWhenPushed = YES;
    userDetailViewController.navigationController.hidesBottomBarWhenPushed=YES;
    [viewController.navigationController pushViewController:userDetailViewController animated:YES];
}

/*
    我的钱包
 */
-(void)presentMyWalletViewControllerOnViewController:(UIViewController *)viewController{
    
    MyWalletViewController *walletViewController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"MyWalletViewController"];
    walletViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:walletViewController animated:YES];
}



-(void)setIccard:(NSString *)iccard InViewController:(MyWalletViewController *)viewController{
    if ([iccard isEqualToString:@""]||iccard == nil) {
        viewController.imgView.hidden = YES;
        viewController.cardId.hidden = YES;
    }else{
        viewController.cardId.text = iccard;
        viewController.imgView.hidden = NO;
        viewController.cardId.hidden = NO;
    }
}

/*
 我的订单
 */
-(void)presentMyOrderViewControllerOnViewController:(UIViewController *)viewController{
    MyOrderViewController *userDetailViewController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"MyOrderViewController"];
    userDetailViewController.hidesBottomBarWhenPushed = YES;
    userDetailViewController.orderType = TradeOrderType;
    [viewController.navigationController pushViewController:userDetailViewController animated:YES];

}
/*
    用户反馈
 */
-(void)presentFeedBackViewControllerOnViewController:(UIViewController *)viewController{
    FeedbackViewController *feedBackViewController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"FeedbackViewController"];
    feedBackViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:feedBackViewController animated:YES];
  
    //友盟反馈
//    UIViewController *feedbackViewController = [UMFeedback feedbackViewController];
//    feedbackViewController.hidesBottomBarWhenPushed = YES;
//    feedbackViewController.title = @"意见反馈";
//    [viewController.navigationController pushViewController:feedbackViewController
//                                                   animated:YES];
}

/*
    我的二维码
 */
-(void)presentQRCodeViewControllerOnViewController:(UIViewController *)viewController{
    QRCodeViewController *qrCodeViewController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"QRCodeViewController"];
    qrCodeViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:qrCodeViewController animated:YES];
}
/*
    应用推荐
 */
-(void)presentAppViewControllerOnViewController:(UIViewController *)viewController{
   AppViewController *appViewController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"AppViewController"];
    appViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:appViewController animated:YES];
}

/*
    联系我们
 */
-(void)callWithPhoneNumber:(NSString *)phoneNumber InViewController:(Index3ViewController *)viewController{
    NSString *tel = [NSString stringWithFormat:@"tel:%@",phoneNumber];
    UIWebView *callWebview = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:tel];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [viewController.view addSubview:callWebview];
}


@end
