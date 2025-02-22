//
//  FinalConfirmViewController.h
//  Club
//
//  Created by dongway on 14-8-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectItemsTableViewController.h"
#import "UIKeyboardViewController.h"
@interface FinalConfirmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SelectedItemsTableViewControllerDelegate,UIKeyboardViewControllerDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)NSArray *items;
@property(nonatomic,strong)NSArray *timeArray;
@property(nonatomic,strong)NSString *totalPriceString;
@property (weak, nonatomic) IBOutlet UILabel *bottomTotalPrice;

@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIButton *payMethod1;
@property (weak, nonatomic) IBOutlet UIButton *payMethod2;
@property (weak, nonatomic) IBOutlet UIButton *sendMethod1;
@property (weak, nonatomic) IBOutlet UIButton *sendMethod2;
@property (weak, nonatomic) IBOutlet UILabel *delivery_limit;
@property (weak, nonatomic)  IBOutlet UIButton *sendTime;
@property (weak, nonatomic) IBOutlet UILabel *shipping_fee;
@property (weak, nonatomic)  IBOutlet UITextField *sendAddress;
@property (weak, nonatomic)  IBOutlet UITextField *userPhone;
@property (weak, nonatomic)  IBOutlet UITextField *userMessage;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@property (weak, nonatomic) IBOutlet UILabel *delivery_scope;
@end
