//
//  PeopleDetailCell.h
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleDetailCell;
@protocol PeopleDetailDelegate<NSObject>
@optional
-(void)requestInCell:(PeopleDetailCell *)cell;
@end
@interface PeopleDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *message;

@property (nonatomic,strong)NSArray *collectionDatas;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectoonHeight;

@property (weak, nonatomic) IBOutlet UIView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property(nonatomic,strong) id<PeopleDetailDelegate>delegate;
@property (nonatomic,strong) UITapGestureRecognizer *goSomeTap;

@end
