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
#import "ChangeLifehallViewController.h"
@interface RobViewController : UIViewController<UIAlertViewDelegate,MartinLiPageScrollViewDelegate,ChangeLifehallDelegate>



@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *goodNums;
@property (nonatomic,strong)NSArray *pageviewDatas;
@end
