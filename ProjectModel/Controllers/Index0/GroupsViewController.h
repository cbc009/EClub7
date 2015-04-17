//
//  GroupsViewController.h
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MartinLiPageScrollView.h"
@interface GroupsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MartinLiPageScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSArray *pageviewDatas;
@property(nonatomic,strong)NSMutableArray *datas;
@end
