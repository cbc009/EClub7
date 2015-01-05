//
//  KillHistoryViewController.h
//  Club
//
//  Created by MartinLi on 14-12-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KillHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSArray *datas;
@end
