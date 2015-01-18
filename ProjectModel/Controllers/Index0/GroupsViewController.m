//
//  GroupsViewController.m
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "GroupsViewController.h"
#import "CurrentGroupCell.h"
#import "GroupService.h"
#import "Groups_Goods.h"
#import <UIImageView+WebCache.h>
#import "GroupDetailViewController.h"
#import "WebViewController.h"
#import "GroupAdCell.h"
#import "Index0Service.h"
@interface GroupsViewController ()
{
    GroupService *groupService;
     Index0Service *index0Service;
    UserInfo *user;
}
@end

@implementation GroupsViewController

-(void)loadView{
    [super loadView];
   }
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    index0Service = [[Index0Service alloc] init];
    groupService = [[GroupService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    _tableview.showsVerticalScrollIndicator =NO;
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [groupService groupsGoodsfutureWithToken:user.token andUser_type:user.user_type intabBarController:self.tabBarController withDone:^(Groups_Info *model){
        self.datas = model.goods;
        [self.tableview reloadData];

    }];
    self.automaticallyAdjustsScrollViewInsets = YES;
    NSString *urlString = [NSString stringWithFormat:AdPictUrl,user.city,1];
    [groupService loadAdverPicFromUrl:urlString inViewController:self];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
 if (alertView.tag==5) {
    if(buttonIndex==1){
        [SharedAction loginAggane];
        NSArray *viewControllers = self.navigationController.viewControllers;
        [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
    }
    }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}
#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
    return self.datas.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        GroupAdCell *cell =[tableView dequeueReusableCellWithIdentifier:@"GroupAdCell" forIndexPath:indexPath];
        cell.pageview.imageType = UIImageUrlType;
        cell.pageview.imgUrls = [index0Service namesFromPictures:self.pageviewDatas];
        cell.pageview.titles = [index0Service titlesFromPictures:self.pageviewDatas];
        cell.pageview.urls = [index0Service urlsFromPictures:self.pageviewDatas];
        cell.pageview.martinLiPageScrollViewDelegate = self;
        cell.pageview.isAutoScroll = YES;
        cell.pageview.titleIsHidden = YES;//默认为NO（可选）
        cell.pageview.height = cell.pageviewHeight.constant;
        cell.pageview.pageViewType = MLPageScrollViewAdvertiseMode;//默认是广告模式（可选）
        cell.pageview.timeInterval = 3;//默认自动滚动图片时间为2秒（可选）
        [cell.pageview updatePageViewInSuperView:self.view];
        return cell;
    }else{
    static NSString *identifier = @"currentGroupCell";
    CurrentGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    Group_Good_Info *model = [self.datas objectAtIndex:row];
    cell.name.text = model.name;
    cell.price.text = [NSString stringWithFormat:@"原价:%@%@",model.price,model.unit];
    cell.discount.text = [NSString stringWithFormat:@"会员价:%@%@",model.discount,model.unit];
    cell.endTime.text = [NSString stringWithFormat:@"%@截止",model.end_time];
    cell.number.text = [NSString stringWithFormat:@"当前参团人数:%@",model.actual_num];
    cell.expectNumber.text = [NSString stringWithFormat:@"%@人起团",model.expect_num];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    
    return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 147;
    }else{
        return 105;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    Group_Good_Info *groupGood = [self.datas objectAtIndex:row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    GroupDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GroupDetailViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.groupGood = groupGood;
}

#pragma MartinLiPageScrollViewDelegate
-(void)imgViewDidTouchActionAtIndex:(NSInteger)index inArray:(NSArray *)array{
    NSString *url = array[index];
    if ([url  hasPrefix:@"http"]) {
        WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        target.urlString = url;
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }else{
        NSLog(@"暂无url");
    }
}
@end
