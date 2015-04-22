//
//  ProvinceViewController.m
//  Club
//
//  Created by MartinLi on 15-4-21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ProvinceViewController.h"
#import "ChangeAgentService.h"
#import "Province_Info.h"
#import "ProviceCell.h"
#import "Agent_Info.h"
#import "AgentViewController.h"
@interface ProvinceViewController ()
{
    ChangeAgentService *changeAgentService;
    NSArray *datas;
}
@end

@implementation ProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择省份";
     self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    changeAgentService=[ChangeAgentService new];
    [changeAgentService publicProvinceInfoWithType:@"2" withDone:^(Province_JSON_Info *model){
        datas=model.arr_province;
        [self.tableView reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Province_Arr_Province *object=datas[indexPath.row];
    ProviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProviceCell" forIndexPath:indexPath];
    cell.title.text=object.province_name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Province_Arr_Province *object=datas[row];
    [changeAgentService publicAgentInfoWithProvionecId:object.province withDone:^(Agent_Info_Info *model){
        UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"ChangeAgent" bundle:nil];
        AgentViewController *agentVIewController =[storBoard instantiateViewControllerWithIdentifier:@"AgentViewController"];
        agentVIewController.datas=model.arr_agent;
        agentVIewController.titles=object.province_name;
        [self.navigationController pushViewController:agentVIewController animated:YES];
    }];
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
