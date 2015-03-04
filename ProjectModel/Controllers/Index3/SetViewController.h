//
//  SetViewController.h
//  Club
//
//  Created by Gao Huang on 15-3-4.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSArray *datas;
@end
