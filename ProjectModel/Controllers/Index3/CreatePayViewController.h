//
//  CreatePayViewController.h
//  Club
//
//  Created by Gao Huang on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
enum{
    ailpayType,
    UPPayType,
    WeiPayType,
};

@interface CreatePayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *price;
@end
