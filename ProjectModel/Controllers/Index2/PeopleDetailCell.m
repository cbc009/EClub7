//
//  PeopleDetailCell.m
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PeopleDetailCell.h"
#import "MessageDetailCell.h"
#import <UIImageView+WebCache.h>
#import "LiveModel.h"
@implementation PeopleDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionDatas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MessageDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MessageDetailCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    Picture_Info *model =self.collectionDatas[row];
//    if (model.picture==nil) {
//        self.collection.hidden=YES;
//    }else{
     [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
//    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

@end
