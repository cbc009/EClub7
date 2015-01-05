//
//  CallPhoneViewController.h
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallPhoneViewController.h"
#import "MartinLiPageScrollView.h"
@interface CallPhoneViewController : UIViewController<MartinLiPageScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *pageviewDatas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong,nonatomic) NSString *minute;

@property (weak, nonatomic) IBOutlet UITextField *minutes;
@property (weak, nonatomic) IBOutlet MartinLiPageScrollView *pageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

- (IBAction)qiandao:(id)sender;


@property (strong,nonatomic) NSMutableArray *datas;
@end
