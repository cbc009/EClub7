//
//  PeopleDetailViewController.h
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"
@interface PeopleDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *cellHeightArray;
@property (nonatomic,strong)NSMutableArray *labelHeightArrar;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)DataInfo *model;
@end
