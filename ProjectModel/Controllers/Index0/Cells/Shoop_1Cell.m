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
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//      NSInteger row = indexPath.row;
    ShoopsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShoopsCollectionViewCell" forIndexPath:indexPath];
  
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate pushShoopsGoodVicIncell:self];
}
- (IBAction)more:(id)sender {
    [self.delegate moreItmes:sender InCell:self];
}
@end
