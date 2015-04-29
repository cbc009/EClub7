//
//  ProvinceViewController.h
//  Club
//
//  Created by MartinLi on 15-4-21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProvinceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)quxiao:(id)sender;

@end
