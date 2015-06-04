//
//  Index1_5Cell.m
//  Club
//
//  Created by MartinLi on 15-4-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "Index1_5Cell.h"
#import "Index0ctionViewCell.h"
#import "Index0Models.h"
#import <UIImageView+WebCache.h>
@implementation Index1_5Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    Index0ctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Index0ctionViewCell" forIndexPath:indexPath];
    Index0Models_Arr_Seller_info *model =self.datas[row];
    cell.goodname.text=model.seller_name;
     [cell.goofPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row =indexPath.row;
    Index0Models_Arr_Seller_info *model =self.datas[row];
    [self.delegate selectIndexInCell:self andSellerId:model.seller_id];
}

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    [self.delegate scrollViewScrollEnable:YES];
//}

#pragma UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.delegate scrollViewScrollEnable:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.delegate scrollViewScrollEnable:NO];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.delegate scrollViewScrollEnable:YES];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self.delegate scrollViewScrollEnable:YES];
}
@end
