//
//  AgentViewController.m
//  Club
//
//  Created by MartinLi on 15-4-21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "AgentViewController.h"
#import "AgentCell.h"
#import "Agent_Info.h"
#import "Index0Service.h"
@interface AgentViewController ()
{
    UserInfo *user;
    Index0Service *index0Service;
}
@end

@implementation AgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.titles;
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    index0Service=[Index0Service new];

    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Agent_Info_Arr_Agent *object=self.datas[indexPath.row];
    AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCell" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.title.text=object.agent_name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row=indexPath.row;
    Agent_Info_Arr_Agent *object=self.datas[row];
    user.agent_id=[object.agent_id integerValue];
    user.agent_name=object.agent_name;
    user.city=[object.city integerValue];
    user.city_name=object.city_name;
    user.lifehall_id=[object.lifehall_id integerValue];
    user.lifehall_name=object.lifehall_name;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AgentReload"
                                                        object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)quxiao:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
