//
//  Shoop_4Cell.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Shoop_4Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *heardPic;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *number;
- (IBAction)remark:(id)sender;
- (IBAction)like:(id)sender;

@end
