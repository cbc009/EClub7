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

@interface RobViewController : UIViewController<UIAlertViewDelegate,MartinLiPageScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *goodNums;
@property (nonatomic,strong)NSArray *pageviewDatas;
@end
