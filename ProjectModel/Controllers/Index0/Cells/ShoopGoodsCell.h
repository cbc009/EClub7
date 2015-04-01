//
//  ShoopGoodsCell.h
//  Club
//
//  Created by MartinLi on 15-3-29.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoopGoodsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsPic;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *goodname;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *vipPrice;
@property (weak, nonatomic) IBOutlet UILabel *nums;

@end
