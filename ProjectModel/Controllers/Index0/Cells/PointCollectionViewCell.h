//
//  PointCollectionViewCell.h
//  Club
//
//  Created by MartinLi on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointCollectionViewCell : UICollectionViewCell
@property (assign ,nonatomic) NSInteger Hight;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *pasPrize;
@property (weak, nonatomic) IBOutlet UILabel *EPrize;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign ,nonatomic) NSInteger wight;
@end
