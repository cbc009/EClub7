//
//  KillListViewController.m
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "KillListViewController.h"
 #import "Seller_Seller_Goods.h"
#import "MJRefresh.h"
#import "KillGoodCell.h"
#import "KillService.h"
#import <UIImageView+WebCache.h>
#import "Kills.h"
#import "KillDetailViewController.h"
#import "KillIconCell.h"
#import "NSString+MT.h"
#import "SellerService.h"
@interface KillListViewController ()
{
    KillService *service;
    SellerService *sellerService;
    NSInteger _page;
    UserInfo *user;
    KillGoodCell *countDownCell;
}
@end

@implementation KillListViewController

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user= sharedData.user;
    self.tableview.tableFooterView =[UIView new];
    sellerService=[SellerService new];
    _tableview.showsVerticalScrollIndicator =NO;
    self.datas=[NSMutableArray new];
    [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
    [self.tableview headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count*2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSInteger index = row/2;
    if (row%2==0) {
        KillIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KillIconCell" forIndexPath:indexPath];
        Seller_Seller_Goods_arr_goods_info *good = self.datas[index];
        cell.dtae.text = good.start_time;
        return cell;
    }else{
        KillGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KillGoodCell" forIndexPath:indexPath];
        Seller_Seller_Goods_arr_goods_info *good = self.datas[index];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,good.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.starttime=[good.start_seconds integerValue];
        cell.name.text = good.goods_name;
        cell.price.text = [NSString stringWithFormat:@"%@元/%@",good.price,good.unit];
        cell.discount.text = [NSString stringWithFormat:@"%@元/%@",good.discount,good.unit];
        return cell;
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger index = indexPath.row/2;
    Seller_Seller_Goods_arr_goods_info *good = self.datas[index];
    KillDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"KillDetailViewController"];
    viewController.good = good;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row%2==0) {
        return 35;
    }else{
        return 95;
    }
}

-(void)headerRereshing{
    _page =1;
    [self loadSellerSellerGoodsTypeWithPage:_page andType:0];
}

-(void)loadSellerSellerGoodsTypeWithPage:(NSInteger)pages andType:(NSInteger)type{
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)pages];
    [sellerService sellerSellerGood_typesWith:@"4" andAgentId:[NSString stringWithFormat:@"%ld",(long)user.agent_id]  andSeller_id:@"0" andLifehall_id:[NSString stringWithFormat:@"%ld",(long)user.lifehall_id] andPage:pageString inTabBarController:self.tabBarController withDone:^(Seller_Seller_Goods_info*model){
        if (type==0) {
            self.datas=(NSMutableArray*)model.arr_goods;
            [self.tableview headerEndRefreshing];
        }else{
            [self.datas addObjectsFromArray:model.arr_goods];
            [self.tableview footerEndRefreshing];
        }
        [self.tableview reloadData];
        
    }];
}

- (void)footerRereshing
{
    _page++;
    [self loadSellerSellerGoodsTypeWithPage:_page andType:1];
}

@end
