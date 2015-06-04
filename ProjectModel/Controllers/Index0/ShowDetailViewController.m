//
//  ShowDetailViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "ShoopGoodsCell.h"
#import "ShoopGoodsViewController.h"
#import "MJRefresh.h"
#import "SellerService.h"
#import "Seller_Seller_Goods.h"
#import <UIImageView+WebCache.h>
@interface ShowDetailViewController ()
{
    NSInteger page;
    SellerService *sellerService;
    UserInfo *user;
}
@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商品列表";
    self.datas=[NSMutableArray new];
    sellerService =[SellerService new];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    [self setupRefresh];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.collectionView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.collectionView.headerPullToRefreshText = @"下拉可以刷新了";
    self.collectionView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.collectionView.headerRefreshingText = @"正在帮你刷新中";
    
    self.collectionView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.collectionView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.collectionView.footerRefreshingText = @"正在帮你加载中";
}


-(void)loadSellerSellerGoodsTypeWithPage:(NSInteger)pages andType:(NSInteger)type{
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)pages];
    [sellerService sellerSellerGood_typesWith:@"1" andAgentId:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andSeller_id:self.seller_id andLifehall_id:[NSString stringWithFormat:@"%ld",(long)user.lifehall_id] andPage:pageString inTabBarController:self.tabBarController withDone:^(Seller_Seller_Goods_info*model){
        if (type==0) {
            self.datas=(NSMutableArray*)model.arr_goods;
            [self.collectionView headerEndRefreshing];
        }else{
            [self.datas addObjectsFromArray:model.arr_goods];
            [self.collectionView footerEndRefreshing];
        }
        [self.collectionView reloadData];
    }];
}
-(void)headerRereshing{
    page=1;
    [self loadSellerSellerGoodsTypeWithPage:page andType:0];
}
- (void)footerRereshing
{
    page++;
    [self loadSellerSellerGoodsTypeWithPage:page andType:1];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    Seller_Seller_Goods_arr_goods_info *model =self.datas[row];
    ShoopGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShoopGoodsCell" forIndexPath:indexPath];
    [cell.goodsPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.goodname.text=model.goods_name;
    cell.nums.text=[NSString stringWithFormat:@"%@人已购买",model.actual_nums];
    cell.price.text=model.price;
    cell.vipPrice.text=model.discount;
    cell.discount.text=[NSString stringWithFormat:@"%0.1f折",[model.discount floatValue]/[model.price floatValue]*10];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    Seller_Seller_Goods_arr_goods_info *models=self.datas[row];
    [sellerService presentShoopGoodsViewControllerIn:self and:models];
}

@end
