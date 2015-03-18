//
//  PastItemsTableViewController.h
//  Club
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PastItemsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (assign, nonatomic) NSInteger page;
@property (nonatomic,strong)NSString *seller_id;
@property(nonatomic,strong)NSMutableArray* datas;

@end
