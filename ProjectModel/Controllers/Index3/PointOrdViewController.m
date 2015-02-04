//
//  PointOrdViewController.m
//  Club
//
//  Created by MartinLi on 14-12-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PointOrdViewController.h"
#import "PointOrderService.h"
#import "PointOdrCell.h"
#import "PointOrder.h"
#import <UIImageView+WebCache.h>
#import "PointOrder.h"
@interface PointOrdViewController ()
{
    PointOrderService *pointOrderService;
    UserInfo *user;
}
@end

@implementation PointOrdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user= sharedData.user;
    pointOrderService = [[PointOrderService alloc] init];
    [pointOrderService loadTradeOrderWithToken:user.token anduser_type:user.user_type inTabBarController:self.tabBarController withdone:^(PointOrderInfo *model){
        self.datas=(NSMutableArray *)model.order;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
       return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PointOdrCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointOdrCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    PointOrder *order = [self.datas objectAtIndex:row];
    cell.name.text = order.demo;
    cell.price.text = [NSString stringWithFormat:@"E币:%@", order.point];
    NSString *str = [order.regtime substringToIndex:10];
    cell.date.text = str;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
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
