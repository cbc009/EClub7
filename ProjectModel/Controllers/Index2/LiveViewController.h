//
//  LiveViewController.h
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveViewController : UIViewController
@property (nonatomic,strong)NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, assign) CGFloat tableViewHeight;
@property (nonatomic, assign) CGFloat labeHeight;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *labeHeightlArray;
@property (nonatomic, strong) NSMutableArray *cellHeightlArray;
@property (nonatomic, strong)NSMutableArray *tableViewheightArray;
@end
