//
//  RobedRecordsTableViewController.h
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RobedRecordsTableViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic ,assign)   int page;
@property(nonatomic,strong)NSString *gid;

@end
