//
//  CheckedViewController.h
//  Club
//
//  Created by MartinLi on 15-3-27.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "Seller_Seller_Goods.h"
@interface CheckedViewController : UIViewController

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *backScrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)buySelf:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyselfs;
- (IBAction)buyOther:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyOthers;
- (IBAction)buyRed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyReds;
- (IBAction)buyMone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyMones;
@property (weak, nonatomic) IBOutlet UILabel *mone;
@property (weak, nonatomic) IBOutlet UILabel *redBag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet UIView *senderView;
@property (weak, nonatomic) IBOutlet UILabel *totlePrice;
@property (nonatomic,strong)Seller_Seller_Goods_arr_goods_info *models;
- (IBAction)buyNow:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buynow;
@property (weak, nonatomic) IBOutlet UIButton *send_time;
- (IBAction)sendTime:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (nonatomic,strong)NSString *numbs;
@property (nonatomic,strong)NSArray *timeArray;
@end
