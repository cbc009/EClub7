//
//  TradeListViewController.m
//  Club
//
//  Created by dongway on 14-8-31.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "TradeListViewController.h"
#import "TradeCell.h"
#import "NSString+MT.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "InternetRequest.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "JSONModelLib.h"
#import "AccountService.h"
@interface TradeListViewController ()
{
    NSInteger page;
    NSMutableArray *datas;
    AccountService *service;
    UserInfo *user;
}
@end

@implementation TradeListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"交易记录";
    page = 1;
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    datas = [[NSMutableArray alloc] initWithArray:self.items];
    service = [AccountService new];
    [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    [self.tableview headerEndRefreshing];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    TradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TradeCell"];
    Trade *trade = [datas objectAtIndex:row];
    cell.type.text = trade.demo;
    cell.time.text = trade.regtime;
    cell.amount.text = trade.amount;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    page = 1;
    [service base_accountWithToken:user.token andUserType:user.user_type inTabBarController:self.tabBarController andPage:page withDone:^(Info *model){
        datas = [NSMutableArray arrayWithArray: model.trade];
        [self.tableview reloadData];
        [self.tableview headerEndRefreshing];
    }];
}

- (void)footerRereshing
{
    page++;
    [service base_accountWithToken:user.token andUserType:user.user_type inTabBarController:self.tabBarController andPage:page withDone:^(Info *model){
        [datas addObjectsFromArray:model.trade];
        [self.tableview reloadData];
        [self.tableview footerEndRefreshing];
    }];
}
@end
