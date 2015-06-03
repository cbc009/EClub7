//
//  GroupsViewController.m
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "GroupsViewController.h"
#import "CurrentGroupCell.h"
#import "MJRefresh.h"
#import "GroupService.h"
#import "Groups_Goods.h"
#import <UIImageView+WebCache.h>
#import "GroupDetailViewController.h"
#import "WebViewController.h"
#import "GroupAdCell.h"
#import "Index0Service.h"
#import "SellerService.h"
#import "Seller_Seller_Goods.h"
@interface GroupsViewController ()
{
    GroupService *groupService;
     Index0Service *index0Service;
    UserInfo *user;
    NSInteger page;
    SellerService *sellerService;
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
    page=0;
    self.title=@"今日巨惠";
    index0Service = [[Index0Service alloc] init];
    sellerService=[SellerService new];
    self.datas=[NSMutableArray new];
    groupService = [[GroupService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.showsVerticalScrollIndicator =NO;
//    self.tableview.tableFooterView =[UIView new];
    [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
    [self.tableview headerBeginRefreshing];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    NSString *urlString = [NSString stringWithFormat:AdPictUrl,user.agent_id,2];
    [groupService loadAdverPicFromUrl:urlString inViewController:self];
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
// if (alertView.tag==5) {
//    if(buttonIndex==1){
//        [SharedAction loginAggane];
//        NSArray *viewControllers = self.navigationController.viewControllers;
//        [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
//    }
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
        self.tableview.bounces=YES;
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
    Seller_Seller_Goods_arr_goods_info *model = [self.datas objectAtIndex:row];
        cell.goodsName.text=model.goods_name;
        [cell.goodsPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.price.text=model.price;
        cell.end_seconds=[model.end_seconds integerValue];
        cell.discount.text=[NSString stringWithFormat:@"￥%@/%@",model.discount,model.unit];
        
        CGFloat actnumbers=([model.discount floatValue]/[model.price floatValue])*10;
        cell.allowance.text=[NSString stringWithFormat:@"%0.1f",actnumbers];
        
        NSMutableAttributedString *actString =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人已团购",model.actual_nums]];
        
        const CGFloat fontSize1 = 18;
        const CGFloat fontSize2 = 14;
        
        UIColor *color = [UIColor redColor];
        UIColor *color1 = [UIColor blackColor];
        
        UIFont *baseFont = [UIFont systemFontOfSize:fontSize1];
        UIFont *baseFont1 = [UIFont systemFontOfSize:fontSize2];
        
        NSUInteger length1 = [model.actual_nums length];
        
        [actString addAttribute:NSFontAttributeName value:baseFont
                           range:NSMakeRange(0, length1)];
        [actString addAttribute:(id)NSForegroundColorAttributeName
                           value:color
                           range:NSMakeRange(0, length1)];
        
        [actString addAttribute:NSFontAttributeName value:baseFont1
                          range:NSMakeRange(length1, 3)];
        [actString addAttribute:(id)NSForegroundColorAttributeName
                          value:color1
                          range:NSMakeRange(length1, 3)];
        
        cell.actnumber.attributedText=actString;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 147;
    }else{
        return 171;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    Seller_Seller_Goods_arr_goods_info *groupGood = [self.datas objectAtIndex:row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    GroupDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GroupDetailViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.groupGood = groupGood;
}
-(void)panInViewControllerWithType:(BOOL)type{
    self.tableview.bounces=type;
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
-(void)headerRereshing
{
    page =1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [sellerService sellerSellerGood_typesWith:@"2" andAgentId:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andSeller_id:@"0" andLifehall_id:[NSString stringWithFormat:@"%ld",(long)user.lifehall_id] andPage:pageString inTabBarController:self.tabBarController withDone:^(Seller_Seller_Goods_info*model){
        self.datas=(NSMutableArray*)model.arr_goods;
        [self.tableview reloadData];
        [self.tableview headerEndRefreshing];
    }];
    
}
- (void)footerRereshing
{
    page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [sellerService sellerSellerGood_typesWith:@"2" andAgentId:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andSeller_id:@"0" andLifehall_id:[NSString stringWithFormat:@"%ld",(long)user.lifehall_id] andPage:pageString inTabBarController:self.tabBarController withDone:^(Seller_Seller_Goods_info*model){
        [self.datas addObjectsFromArray:model.arr_goods];
        [self.tableview reloadData];
        [self.tableview headerEndRefreshing];
    }];
    
}
@end
