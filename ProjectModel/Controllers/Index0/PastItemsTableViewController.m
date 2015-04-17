//
//  PastItemsTableViewController.m
//  Club
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PastItemsTableViewController.h"
#import "PastRobItemCell.h"
#import "Rob_goods_history.h"
#import <UIImageView+WebCache.h>
#import "NSString+MT.h"
#import "MJRefresh.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "AddMorePasItem.h"
#import "RobedRecordsViewController.h"
@interface PastItemsTableViewController ()
{
    AddMorePasItem *addMorePasItem;
    UserInfo *user;
}
@end

@implementation PastItemsTableViewController

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    addMorePasItem = [[AddMorePasItem alloc] init];
    self.title = @"往期免费抢商品";
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    [SharedAction setupRefreshWithTableView:self.tableView toTarget:self];
    [self.tableView headerBeginRefreshing];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    [self.tableview headerEndRefreshing];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    PastItem *item = [self.datas objectAtIndex:indexPath.section];
    static NSString *identifier = @"PastRobItemCell";
    UINib *nib = [UINib nibWithNibName:@"PastRobItemCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    PastRobItemCell *cell = (PastRobItemCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    // Configure the cell...
       [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,item.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.name.text = [NSString stringWithFormat:@"%@",item.name];
    cell.pastPrice.text = [NSString stringWithFormat:@"原价:%@元",item.price];
    return cell;
}


//[SharedAction setupRefreshWithTableView:self.tableView toTarget:self];里定义的headerRereshing  footerRereshing
-(void)headerRereshing
{
    _page =1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *lifeHall_id =[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
    [addMorePasItem rob_goods_historyWithLifehallId:lifeHall_id andSellerId:self.seller_id andPage:pageString inTabBarController:self.tabBarController withDone:^(Rob_goods_history_info *model){
        self.datas = (NSMutableArray *)model.arr_goods;
        [self.tableview reloadData];
        [self.tableView headerEndRefreshing];
    }];
}

- (void)footerRereshing
{
    _page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *lifeHall_id =[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
    [addMorePasItem rob_goods_historyWithLifehallId:lifeHall_id andSellerId:self.seller_id andPage:pageString inTabBarController:self.tabBarController withDone:^(Rob_goods_history_info *model){
        [self.datas addObjectsFromArray:model.arr_goods];
        [self.tableview reloadData];
        [self.tableView footerEndRefreshing];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}
@end
