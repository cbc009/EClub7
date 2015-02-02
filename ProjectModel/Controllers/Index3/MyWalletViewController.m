//
//  MyWalletViewController.m
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "MyWalletViewController.h"
#import "TradeListViewController.h"
#import "CreatePayViewController.h"
#import "Index3Service.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "BalanceModel.h"
@interface MyWalletViewController ()
{
    Index3Service *service;
}
@end

@implementation MyWalletViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    self.title = @"我的钱包";
    [SharedAction baseBalanceWithToken:user.token andUser_type:user.user_type withTabBarViewController:self.tabBarController doneObject:^(BalanceIfo *model){
        user.phone_minute = model.phone_minute;
        user.amount = model.amount;
        user.point = model.point;
        user.amount_red = model.amount_red;
        self.redbag.text =[NSString stringWithFormat:@"%0.2f",user.amount_red];
        self.amount.text = [NSString stringWithFormat:@"%0.2f",user.amount];
        self.cardId.text = user.iccard;
        self.Point.text = [NSString stringWithFormat:@"%ld",(long)user.point];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"tradeRecorders"]) {
//        TradeListViewController *viewController = segue.destinationViewController;
     }

}


@end
