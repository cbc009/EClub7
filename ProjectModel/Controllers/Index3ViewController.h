//
//  Index3ViewController.h
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
@interface Index3ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,LoginViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
