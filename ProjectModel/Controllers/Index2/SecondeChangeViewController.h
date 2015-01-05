//
//  SecondeChangeViewController.h
//  Club
//
//  Created by MartinLi on 14-12-21.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondeChangeViewController : UIViewController
@property (nonatomic,strong)NSArray *datas;
- (IBAction)segAction:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
