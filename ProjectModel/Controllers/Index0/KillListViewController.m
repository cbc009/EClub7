//
//  KillListViewController.m
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "KillListViewController.h"
#import "KillGoodCell.h"
#import "KillService.h"
#import <UIImageView+WebCache.h>
#import "Kills.h"
#import "KillDetailViewController.h"
#import "KillIconCell.h"
#import "NSString+MT.h"
@interface KillListViewController ()
{
    KillService *service;
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
    self.tableview.tableFooterView =[UIView new];
    service = [[KillService alloc] init];
    _tableview.showsVerticalScrollIndicator =NO;
    SharedData *shareData = [SharedData sharedInstance];
    [service goods_futureWithToken:shareData.user.token andUser_type:shareData.user.user_type inTabBarController:self.tabBarController withDone:^(KillGoodInfo *model){
        self.datas = model.goods;
        for (int i=0; i<model.goods.count; i++) {
            KillGood *good  = self.datas[i];
            NSString *startTime2 = [NSString timeType1FromStamp:good.starttime];//yyyy-MM-dd HH:mm:ss
            NSString *notifyTime = [NSString dateStringByAddTimeInterval:-120 fromDateString:startTime2 withDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
            [SharedAction setLocalNotifyWithAlertBody:[NSString stringWithFormat:@"%@的秒杀马上就要开始了,请留意哦",startTime2] andType:@"Kill" andFireDate:notifyTime];
        }
        [self.tableview reloadData];
    }];
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag==5) {
//        if(buttonIndex==1){
//            [SharedAction loginAggane];
//            NSArray *viewControllers = self.navigationController.viewControllers;
//            [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
//        }
//    }
//}
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
        KillGood *good = self.datas[index];
        cell.date.text = good.start_time;
        if (good.seconds==0) {
            cell.backImage.image = [UIImage imageNamed:@"finish_kill_bg"];
        }
        return cell;
    }else{
        KillGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KillGoodCell" forIndexPath:indexPath];
        KillGood *good = self.datas[index];
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
