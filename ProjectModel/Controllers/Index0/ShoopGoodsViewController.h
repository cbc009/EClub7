//
//  ShoopGoodsViewController.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seller_Seller_Goods.h"
@interface ShoopGoodsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *reduce;
- (IBAction)reduceNumbs:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myWebViewHeight;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *add;
- (IBAction)addnumbs:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numbs;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buyNow;
- (IBAction)share:(id)sender;
- (IBAction)buyNow:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *bigPicture;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *workTime;
@property (nonatomic,strong)Seller_Seller_Goods_arr_goods_info *models;
@property (weak, nonatomic) IBOutlet UILabel *vipPrice;
@end
