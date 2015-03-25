//
//  
//  Club
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RobModel.h"
#import "MartinLiPageScrollView.h"
#import <RMPickerViewController.h>
@interface RobViewController : UIViewController<UIAlertViewDelegate,MartinLiPageScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) RMPickerViewController *pickerVC;
@property (nonatomic,strong)NSMutableArray *goodNums;
@property (nonatomic,strong)NSArray *pageviewDatas;
@property (nonatomic,strong)NSArray *datas1;
@end
