//
//  RobedRecordsViewController.h
//  Club
//
//  Created by MartinLi on 15-3-9.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RobedRecordsViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic ,assign)   int page;
@property(nonatomic,strong)NSString *gid;
@end
