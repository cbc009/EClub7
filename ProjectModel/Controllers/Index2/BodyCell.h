//
//  BodyCell.h
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveService.h"
#import "LiveData.h"
@interface BodyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIImageView *herad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableHeight;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableFarm;
@property (nonatomic,strong)NSMutableArray *data;
//-(void)setCellContent:(LiveData *)data;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
