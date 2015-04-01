//
//  ShoopsViewController.h
//  Club
//
//  Created by MartinLi on 15-3-25.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoopsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *data;

@end
