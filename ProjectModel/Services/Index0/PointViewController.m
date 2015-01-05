//
//  PointViewController.m
//  Club
//
//  Created by MartinLi on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PointViewController.h"
#import "PointCollectionViewCell.h"
#import "PointViewControllerService.h"
#import <UIImageView+WebCache.h>
#import "SharedData.h"
#import "Login.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
@interface PointViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSString *identifier;
    PointVIewControllerService *pointViewControllerService;
    NSMutableDictionary *dic;
}

@end

@implementation PointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品兑换";
    self.page = 1;
    identifier = @"PointCollectionViewCell";
    pointViewControllerService  = [[PointVIewControllerService alloc] init];
    dic = [[NSMutableDictionary alloc] init];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width/2, ItemHeight*5);
    layout.minimumInteritemSpacing = 0;
    self.collectionview.collectionViewLayout = layout;
    UINib *nib = [UINib nibWithNibName:@"PointCollectionViewCell" bundle:nil];
    [self.collectionview registerNib:nib forCellWithReuseIdentifier:identifier];
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}
#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
    NSLog(@"%ld",(long)self.datas.count);
}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PointCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PointCollectionViewCell" forIndexPath:indexPath];
    dic = self.datas[indexPath.row];
    NSLog(@"%@",dic);
    Cell.name.text = [dic valueForKey:@"name"];
    NSLog(@"%@",[dic valueForKey:@"picture"]);
    Cell.pasPrize.text = [NSString stringWithFormat:@"%@元/%@",[dic valueForKey:@"price"],[dic valueForKey:@"unit"]];
    [Cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,[dic valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"e"]];
    Cell.EPrize.text =[NSString stringWithFormat:@"E: %@",[dic valueForKey:@"point"]];
    return Cell;
}
#pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSLog(@"didSelect:%ld",(long)row);
    dic = self.datas[row];
    [pointViewControllerService presentPointGoodViewControllerWithDatas:dic OnPointViewController:self];
   
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_collectionview addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_collectionview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_collectionview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _collectionview.headerPullToRefreshText = @"下拉可以刷新了";
    _collectionview.headerReleaseToRefreshText = @"松开马上刷新了";
    _collectionview.headerRefreshingText = @"正在帮你刷新中";
    
    _collectionview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _collectionview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _collectionview
    .footerRefreshingText = @"正在帮你加载中";
}
-(void)headerRereshing
{
    _page=1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)_page];
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    [pointViewControllerService loadDataWithToken:user.token andUser_type:user.user_type AndPage:pageString OnViewCOntroller:self];
    [_collectionview headerEndRefreshing];
    
}


- (void)footerRereshing
{
    _page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)_page];
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    [pointViewControllerService loadMoreDataWithToken:user.token andUser_type:user.user_type AndPage:pageString OnViewCOntroller:self];
    [_collectionview footerEndRefreshing];
}

//-(void)setSelectedColorInCollectionView:(UICollectionView *)collectionView withSelectedRow:(NSInteger)row withDatas:(NSArray *)datas{
//    NSInteger count = 2;
//}
@end
