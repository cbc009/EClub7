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

@interface PointOrdViewController ()
{
    PointOrderService *pointOrderService;
}
@end

@implementation PointOrdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pointOrderService = [[PointOrderService alloc] init];
    [pointOrderService loadTradeOrderInViewController:self];
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
    NSLog(@"%@",self.datas);

     return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PointOdrCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointOdrCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    PointOrder *order = [self.datas objectAtIndex:row];
    NSLog(@"%@",order);
    NSLog(@"%@,%@,%@",order.point,order.demo,order.regtime);
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
    return 55;
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
