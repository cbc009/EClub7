//
//  MorePush_history.m
//  Club
//
//  Created by MartinLi on 14-11-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "MorePush_history.h"
#import "MorePush_historyService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "PushHistoryCell.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "Push_history.h"
#import "NSString+MT.h"
@interface MorePush_history ()
{
    MorePush_historyService *morePush_historyService;
    int page;
    UserInfo *user;
}
@end

@implementation MorePush_history

-(void)loadView{
    [super loadView];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SharedData *sharedData = [SharedData sharedInstance];
    user= sharedData.user;
    [SharedAction setupRefreshWithTableView:self.tableView toTarget:self];
    [self.tableView headerBeginRefreshing];
    page = 1;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    morePush_historyService = [[MorePush_historyService alloc] init];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    [self.tableView headerEndRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PushHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PushHistoryCell" forIndexPath:indexPath];
   push *model = self.datas[indexPath.section];
    cell.news.text = model.content;
    cell.labelHeight.constant=[NSString heightWithString:model.content font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-32, 300)];
    cell.time.text = model.regtime;
    cell.bgView.layer.cornerRadius=4;
    cell.title.text=model.title;
    cell.bgView.layer.borderWidth=1;
    [cell.bgView.layer setBorderColor:[SharedAction colorWithHexString:@"#dddddd"].CGColor];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    push *model = self.datas[indexPath.section];
//    NSString *news =model.content;
//    [SVProgressHUD showSuccessWithStatus:news];
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    push *model = self.datas[indexPath.section];
   return [NSString heightWithString:model.content font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-32, 300)]+65;

}

-(void)headerRereshing
{
    page=1;
    NSString *pageString = [NSString stringWithFormat:@"%d",page];
    [SVProgressHUD show];
    [morePush_historyService loadPush_historyWithAgentID:user.agent_id andPage:pageString inTabBarcontroller:self.tabBarController withdon:^(PushInfo *model){
        self.datas =(NSMutableArray *)model.arr_info;
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    }];
}

- (void)footerRereshing
{
    page++;
    NSString *pageString = [NSString stringWithFormat:@"%d",page];
    [SVProgressHUD show];
    [morePush_historyService loadPush_historyWithAgentID:user.agent_id andPage:pageString inTabBarcontroller:self.tabBarController withdon:^(PushInfo *model){
        [self.datas addObjectsFromArray:model.arr_info ];
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
