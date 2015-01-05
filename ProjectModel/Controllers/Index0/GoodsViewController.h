//
//  GoodsViewController.h
//  Club
//
//  Created by Gao Huang on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLFloatButton.h"
@interface GoodsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong ,nonatomic) MLFloatButton *floatButton;
@property(nonatomic,strong)NSArray *subtypes;
@property(nonatomic,strong)NSMutableArray *datas;
@end
