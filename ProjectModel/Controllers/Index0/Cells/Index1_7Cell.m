//
//  Index1_7Cell.m
//  Club
//
//  Created by MartinLi on 15-4-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "Index1_7Cell.h"
#import "Index1ctionViewCell.h"
#import "Index0Models.h"
#import <UIImageView+WebCache.h>
@implementation Index1_7Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    Index1ctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Index1ctionViewCell" forIndexPath:indexPath];
     Index0Models_Arr_Goods_info *model =self.datas[row];
    cell.goodName.text=model.goods_name;
    [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.price.text=[NSString stringWithFormat:@"￥%@/%@",model.discount,model.unit];
    cell.actunat.text=[NSString stringWithFormat:@"%@人已购买",model.actual_nums];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
   Index0Models_Arr_Goods_info *model =self.datas[row];
    [self.delegate selectIndexInCell:self andGoodsId:model.goods_id];
}
@end
