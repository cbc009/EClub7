//
//  ShoopsViewController.m
//  Club
//
//  Created by MartinLi on 15-3-25.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShoopsViewController.h"
#import "ShoopsCell.h"
#import "ShoopDetailViewController.h"
@interface ShoopsViewController ()

@end

@implementation ShoopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商家";
    self.tableview.backgroundColor=[SharedAction colorWithHexString:@"#f2f2f2"];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoopsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ShoopsCell" forIndexPath:indexPath];
    cell.backgroundColor=[SharedAction colorWithHexString:@"#f2f2f2"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShoopDetailViewController *shoopDetailVic=[storBoard instantiateViewControllerWithIdentifier:@"ShoopDetailViewController"];
//    [self presentViewController:shoopDetailVic animated:YES completion:nil];
    [self.navigationController pushViewController:shoopDetailVic animated:YES];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 4;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
