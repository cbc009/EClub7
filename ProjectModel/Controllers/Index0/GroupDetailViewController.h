//
//  GroupDetailViewController.h
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Groups_Goods.h"
#import "Group_History_Goods.h"
@interface GroupDetailViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *goodPicture;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) NSArray *datas;
//- (IBAction)segMented:(UISegmentedControl *)sender;
@property(nonatomic,strong)Group_Good_Info *groupGood;
@property(nonatomic,strong)Group_History_Goods_Info *historyGorupGood;
- (IBAction)pay:(id)sender;
@property(nonatomic,strong)NSString *number;
@property(nonatomic,assign)NSInteger num;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webviewHeight;
@property (weak, nonatomic) IBOutlet UILabel *numbs;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *people;
- (IBAction)reduce:(id)sender;
- (IBAction)add:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBut;
@property (weak, nonatomic) IBOutlet UIButton *reduceBut;
@property (weak, nonatomic) IBOutlet UILabel *numbes;

@end
