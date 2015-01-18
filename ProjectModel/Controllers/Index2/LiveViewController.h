//
//  LiveViewController.h
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BodyCell.h"
#import "LifeHallService.h"
@interface LiveViewController : UIViewController <BodyTableViewCellDelegate>
@property (nonatomic,strong)NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *labeHeightlArray;
@property (nonatomic, strong) NSMutableArray *cellHeightlArray;
@property (nonatomic,strong) NSMutableArray *tabelCellHeightArray;
@property (weak, nonatomic) IBOutlet UITextView *content;
@end
