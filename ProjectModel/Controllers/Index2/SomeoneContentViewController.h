//
//  SomeoneContentViewController.h
//  Club
//
//  Created by MartinLi on 15-2-3.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"
@interface SomeoneContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *heardPic;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contenHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *regtime;
@property(nonatomic,strong)DataInfo *model;

@property (weak, nonatomic) IBOutlet UIButton *contentSender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectoonHeight;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@property (weak, nonatomic) IBOutlet UIView *collectionView;
- (IBAction)contenAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollvice;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *datas;
@end
