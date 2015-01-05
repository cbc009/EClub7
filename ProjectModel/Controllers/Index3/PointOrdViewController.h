//
//  PointOrdViewController.h
//  Club
//
//  Created by MartinLi on 14-12-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointOrdViewController : UIViewController
@property (nonatomic ,strong) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
