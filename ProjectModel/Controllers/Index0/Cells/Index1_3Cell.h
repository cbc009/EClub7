//
//  Index1_3Cell.h
//  Club
//
//  Created by MartinLi on 15-4-17.
//  Copyright (c) 2015年 martin. All rights reserved.
//
#import "Index1_3Cell.h"
#import <UIKit/UIKit.h>
@class Index1_3Cell;
@protocol TapinViewDelegate<NSObject>
-(void)tapInViewWithTag:(NSInteger)tag inCell:(Index1_3Cell*)cell;
@end
@interface Index1_3Cell : UITableViewCell
@property (nonatomic,weak)id<TapinViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *robView;
@property (weak, nonatomic) IBOutlet UIView *teamView;
@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (weak, nonatomic) IBOutlet UIView *killView;
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UIImageView *robGoodPic;
@property (weak, nonatomic) IBOutlet UILabel *robDetail;
@property (weak, nonatomic) IBOutlet UILabel *robTitle;
@property (weak, nonatomic) IBOutlet UILabel *robB;

@property (weak, nonatomic) IBOutlet UILabel *teamTitle;
@property (weak, nonatomic) IBOutlet UILabel *temaDetail;
@property (weak, nonatomic) IBOutlet UIImageView *teamPic;

@property (weak, nonatomic) IBOutlet UILabel *dayNew;
@property (weak, nonatomic) IBOutlet UILabel *dayDetail;
@property (weak, nonatomic) IBOutlet UIImageView *dayPic;


@property (weak, nonatomic) IBOutlet UILabel *pointTitle;
@property (weak, nonatomic) IBOutlet UILabel *pointDetail;
@property (weak, nonatomic) IBOutlet UIImageView *pointPic;


@property (weak, nonatomic) IBOutlet UIImageView *killPic;
@property (weak, nonatomic) IBOutlet UILabel *killDetail;
@property (weak, nonatomic) IBOutlet UILabel *KillName;
@end
