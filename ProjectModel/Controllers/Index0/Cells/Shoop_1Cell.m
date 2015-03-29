//
//  Shoop_1Cell.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "Shoop_1Cell.h"
#import "ShoopsCollectionViewCell.h"
#import "ShoopGoodsViewController.h"
#import <UIImageView+WebCache.h>

@implementation Shoop_1Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.collection.showsHorizontalScrollIndicator=NO;

    // Configure the view for the selected state
}
#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    ShoopsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShoopsCollectionViewCell" forIndexPath:indexPath];
    Seller_Seller_Goods_arr_goods_info *model =self.datas[row];
    cell.goodsName.text=model.goods_name;
    [cell.goodsPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Seller_Seller_Goods_arr_goods_info *model =self.datas[indexPath.row];
    [self.delegate pushShoopsGoodVicIncell:self andModel:model];
}
- (IBAction)more:(id)sender {
    [self.delegate moreItmes:sender InCell:self];
}
@end
