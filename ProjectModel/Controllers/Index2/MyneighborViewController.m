//
//  MyneighborViewController.m
//  Club
//
//  Created by MartinLi on 14-12-8.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "MyneighborViewController.h"
#import "NeighborViewCell.h"
#import "NeighborService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import <UIImageView+WebCache.h>
#import "MJRefresh.h"
@interface MyneighborViewController ()
{
    NSString *identifier;
    NSInteger page;
    NSMutableDictionary *dic;


}
@end

@implementation MyneighborViewController


-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的邻居";
    page =1;
    dic = [[NSMutableDictionary alloc] init];
    
    
//    [self setupRefresh];
    
    identifier =@"NeighborViewCell";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NeighborViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    dic = self.datas[indexPath.section];
    cell.phone.text = [dic valueForKey:@"nickname"];
    [cell.neighborimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,[dic valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"e"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}
//- (void)setupRefresh
//{
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [_tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [_tableview headerBeginRefreshing];
//    
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [_tableview addFooterWithTarget:self action:@selector(footerRereshing)];
//    
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    _tableview.headerPullToRefreshText = @"下拉可以刷新了";
//    _tableview.headerReleaseToRefreshText = @"松开马上刷新了";
//    _tableview.headerRefreshingText = @"正在帮你刷新中";
//    
//    _tableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    _tableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
//    _tableview.footerRefreshingText = @"正在帮你加载中";
//}
//-(void)headerRereshing
//{
//    page=1;
//    NeighborService *neighborService = [[NeighborService alloc] init];
//    SharedData *sharedData = [SharedData sharedInstance];
//    UserInfo *user = sharedData.user;
//    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
////    [neighborService loadNeighborPhoneWithMId:user.mid andSid:user.sid andPage:pageString OnViewController:self];
////    [_tableview headerEndRefreshing];
//    
//}
//
//
//- (void)footerRereshing
//{
//    page++;
//    NeighborService *neighborService = [[NeighborService alloc] init];
//    SharedData *sharedData = [SharedData sharedInstance];
//    UserInfo *user = sharedData.user;
//    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
////    [neighborService loadMoreNeighborPhoneWithMId:user.mid andSid:user.sid andPage:pageString OnViewController:self];
////    [_tableview footerEndRefreshing];
//}
@end
