//
//  CheckedViewController.h
//  Club
//
//  Created by MartinLi on 15-3-27.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
@interface CheckedViewController : UIViewController

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *backScrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)buySelf:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyselfs;
- (IBAction)buyOther:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyOthers;

@end
