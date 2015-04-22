//
//  GroupHistoryViewController.m
//  Club
//
//  Created by MartinLi on 15-1-9.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "GroupHistoryViewController.h"
#import "Groups_Goods.h"
#import <UIImageView+WebCache.h>
#import "CurrentGroupCell.h"
#import "GroupDetailViewController.h"
#import "GroupService.h"
#import "Groups_Goods.h"
#import "Group_History_Goods.h"
#import "MJRefresh.h"
@interface GroupHistoryViewController ()
{
    GroupService *groupService;
    UserInfo *user;
    NSInteger page;

}
@end

@implementation GroupHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    groupService = [[GroupService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.tableView.showsVerticalScrollIndicator =NO;
    self.tableView.tableFooterView=[UIView new];
    [SharedAction setupRefreshWithTableView:self.tableView toTarget:self];
      [self.tableView headerBeginRefreshing];
      self.automaticallyAdjustsScrollViewInsets = YES;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *identifier = @"currentGroupCell";
        CurrentGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        NSInteger row = indexPath.row;
        Group_History_Goods_Info *model = [self.datas objectAtIndex:row];
        cell.name.text = model.name;
        cell.price.text = [NSString stringWithFormat:@"原价:%@%@",model.price,model.unit];
        cell.discount.text = [NSString stringWithFormat:@"会员价:%@%@",model.discount,model.unit];
        cell.number.text = [NSString stringWithFormat:@"已参团人数:%@",model.actual_num];
        cell.expectNumber.text = [NSString stringWithFormat:@"%@人参团",model.expect_num];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    Group_History_Goods_Info *groupGood = [self.datas objectAtIndex:row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    GroupDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GroupDetailViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.historyGorupGood = groupGood;
}
-(void)headerRereshing
{
    page =1;
    NSString *pageString =[NSString stringWithFormat:@"%ld",(long)page];
    [groupService groupsGoodsHistoryWithToken:user.token andUser_type:user.user_type withTabBarController:self.tabBarController andPage:pageString withDone:^(Group_History_Info *model){
        self.datas=(NSMutableArray *)model.goods;
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    }];


}
- (void)footerRereshing
{
    page++;
    NSString *pageString =[NSString stringWithFormat:@"%ld",(long)page];
    [groupService groupsGoodsHistoryWithToken:user.token andUser_type:user.user_type withTabBarController:self.tabBarController andPage:pageString withDone:^(Group_History_Info *model){
        [self.datas addObjectsFromArray:model.goods];;
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
