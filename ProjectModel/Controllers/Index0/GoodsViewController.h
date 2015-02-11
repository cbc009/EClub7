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
@property(nonatomic,strong)NSArray *subtypes;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segment;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)NSString *titletext;
@end
