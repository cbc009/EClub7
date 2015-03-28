//
//  ShoopGoodsViewController.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoopGoodsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *reduce;
- (IBAction)reduceNumbs:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *add;
- (IBAction)addnumbs:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numbs;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buyNow;
- (IBAction)share:(id)sender;
- (IBAction)buyNow:(id)sender;

@end
