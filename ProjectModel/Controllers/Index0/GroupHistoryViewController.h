//
//  GroupHistoryViewController.h
//  Club
//
//  Created by MartinLi on 15-1-9.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *datas;
@end
