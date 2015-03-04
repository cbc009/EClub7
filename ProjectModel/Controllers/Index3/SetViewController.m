//
//  SetViewController.m
//  Club
//
//  Created by Gao Huang on 15-3-4.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "SetViewController.h"
#import "Index3_1Cell.h"
@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SetViewController

-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datas = [[NSArray alloc] initWithObjects:@"指纹密码", nil];
    self.tableview.tableFooterView = [UIView new];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Index3_1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Index3_1Cell" forIndexPath:indexPath];
    cell.title.text = self.datas[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *target = [self.storyboard instantiateViewControllerWithIdentifier:@"TouchIDSetViewController"];
    [self.navigationController pushViewController:target animated:YES];
}
@end
