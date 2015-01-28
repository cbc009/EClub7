//
//  FeedbackViewController.h
//  Club
//
//  Created by dongway on 14-8-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "FeedBackCell.h"
@interface FeedbackViewController : UIViewController<UIKeyboardViewControllerDelegate,FeedbackDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSArray *datas;
@end
