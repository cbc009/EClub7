//
//  ShowDetailViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "PointCollectionViewCell.h"
#import "ShoopGoodsViewController.h"
@interface ShowDetailViewController ()

@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PointCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PointCollectionViewCell" forIndexPath:indexPath];
//    dic = self.datas[indexPath.row];
//    Cell.name.text = [dic valueForKey:@"name"];
//    [Cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,[dic valueForKey:@"picture"]]] placeholderImage:[UIImage imageNamed:@"e"]];
//    Cell.EPrize.text =[NSString stringWithFormat:@"%@E币",[dic valueForKey:@"point"]];
    return Cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    NSInteger row = indexPath.row;
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShoopGoodsViewController *shoopGoodVic=[storBoard instantiateViewControllerWithIdentifier:@"ShoopGoodsViewController"];
    [self.navigationController pushViewController:shoopGoodVic animated:YES];
}

@end
