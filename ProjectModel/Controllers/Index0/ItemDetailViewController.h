//
//  ItemDetailViewController.h
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Type_goods.h"
#import "Search_goods.h"
#import "MLFloatButton.h"
@interface ItemDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webviewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *pastPrice;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *Ems;
@property (strong, nonatomic) MLFloatButton *floatButton;
- (IBAction)buynow:(id)sender;
//@property (weak, nonatomic) IBOutlet UILabel *ems;

@property(strong,nonatomic) Type_goods_good *goodModel;
//@property(strong,nonatomic) Search_goods_good *SearchModel;
@end
