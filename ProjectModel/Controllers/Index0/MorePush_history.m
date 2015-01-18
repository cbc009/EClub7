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
@interface MorePush_history ()
{
    MorePush_historyService *morePush_historyService;
    NSMutableDictionary *dic;
    int page;
}
@end

@implementation MorePush_history

-(void)loadView{
    [super loadView];
    [self setupRefresh];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    dic = [[NSMutableDictionary alloc] init];
    page = 1;
    morePush_historyService = [[MorePush_historyService alloc] init];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
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
    dic = self.datas[indexPath.section];
    cell.news.text = [dic valueForKey:@"content"];
    cell.time.text = [dic valueForKey:@"regtime"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    dic = self.datas[indexPath.section];
    NSString *news = [dic valueForKey:@"content"];
    [SVProgressHUD showSuccessWithStatus:news];
    
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉可以刷新了";
    _tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _tableView.headerRefreshingText = @"正在帮你刷新中";
    
    _tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _tableView
    .footerRefreshingText = @"正在帮你加载中";
}
-(void)headerRereshing
{
    page=1;
    NSString *pageString = [NSString stringWithFormat:@"%d",page];
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    [morePush_historyService loadPush_historyWithToken:user.token andUser_type:user.user_type andPage:pageString InViewController:self];
    
}



- (void)footerRereshing
{
    page++;
    NSString *pageString = [NSString stringWithFormat:@"%d",page];
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    [morePush_historyService loadMorePush_historyWithToken:user.token andUser_type:user.user_type andPage:pageString InViewController:self];
    [_tableView footerEndRefreshing];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
