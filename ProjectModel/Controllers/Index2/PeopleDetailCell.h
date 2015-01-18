//
//  PeopleDetailCell.h
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (nonatomic,strong)NSArray *collectionDatas;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableHeight;
@property (weak, nonatomic) IBOutlet UILabel *time;
@end
