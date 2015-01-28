//
//  ChooseAreaViewController.h
//  Club
//
//  Created by dongway on 14-8-17.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "DatasTableViewController.h"
#import "Member_Login.h"
@interface ChooseAreaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DatasTableViewControllerDelegate>
@property(nonatomic,retain)UserInfo *user;
@property(nonatomic,retain)LoginViewController *loginViewController;
@property (nonatomic,assign)NSInteger market;
@end
