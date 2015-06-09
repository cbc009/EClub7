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
//{
//    Index3Service *service;
//}
@end

@implementation MyWalletViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    SharedData *sharedData =[SharedData sharedInstance];
    UserInfo *user =sharedData.user;
        self.redbag.text =[NSString stringWithFormat:@"%0.2f",user.amount_red];
        self.amount.text = [NSString stringWithFormat:@"%0.2f",user.amount];
        self.cardId.text = user.iccard;
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
     }

}


@end
