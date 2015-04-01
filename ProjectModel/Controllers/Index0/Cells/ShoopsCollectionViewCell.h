//
//  ShoopsCollectionViewCell.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoopsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsPic;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@end
