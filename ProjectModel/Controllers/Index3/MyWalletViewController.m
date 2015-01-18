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
@interface MyWalletViewController ()
{
    Index3Service *service;
}
@end

@implementation MyWalletViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.redbag.font.pointSize = 0.00;
    // Do any additional setup after loading the view.
    self.title = @"我的钱包";
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    self.redbag.text =[NSString stringWithFormat:@"%0.2f",user.amount_red];
    self.amount.text = [NSString stringWithFormat:@"%0.2f",user.amount];
    self.Point.text = [NSString stringWithFormat:@"%ld",(long)user.point];
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
//        viewController.items = self.datas;
    }

}


@end
