//
//  MysecondeViewController.h
//  Club
//
//  Created by MartinLi on 14-12-24.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MysecondeViewController : UIViewController
@property (nonatomic,strong)NSArray *datas;

- (IBAction)segment:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
