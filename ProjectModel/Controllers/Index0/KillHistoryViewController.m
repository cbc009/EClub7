//
//  KillHistoryViewController.m
//  Club
//
//  Created by MartinLi on 14-12-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "KillHistoryViewController.h"
#import "KillGoodCell.h"
#import "KillService.h"
#import <UIImageView+WebCache.h>
#import "KillHistorModel.h"
#import "KillDetailViewController.h"
#import "KillIconCell.h"
@interface KillHistoryViewController ()
{
    KillService *service;
}
@end

@implementation KillHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"历史秒杀";
    // Do any additional setup after loading the view.
    service = [[KillService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    _tableview.showsVerticalScrollIndicator =NO;
    self.tableview.tableFooterView =[UIView new];
    [service kill_Goods_historyWithToken:user.token andUser_type:user.user_type intabBarController:self.tabBarController withDone:^(KillGoodInfo1 *model){
        self.datas = (NSMutableArray *)model.goods;
        [self.tableview reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count*2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSInteger index = row/2;
    if (row%2==0) {
        KillIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KillIconCell" forIndexPath:indexPath];
        KillGood1 *good = self.datas[index];
        cell.date.text = good.start_time;
        cell.backImage.image = [UIImage imageNamed:@"finish_kill_bg"];
        return cell;
    }else{
        KillGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KillGoodCell" forIndexPath:indexPath];
        KillGood1 *good = self.datas[index];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,good.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.name.text = good.name;
        cell.price.text = [NSString stringWithFormat:@"%@元/%@",good.price,good.unit];
        cell.discount.text = [NSString stringWithFormat:@"%@元/%@",good.discount,good.unit];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger index = indexPath.row/2;
    KillGood *good = self.datas[index];
    KillDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"KillDetailViewController"];
    viewController.good = good;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row%2==0) {
        return 40;
    }else{
        return 95;
    }
}



@end
