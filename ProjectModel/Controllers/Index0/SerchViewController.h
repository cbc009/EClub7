//
//  SerchViewController.h
//  Club
//
//  Created by MartinLi on 14-12-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SerchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property(nonatomic,strong)NSArray *datas;


@end
