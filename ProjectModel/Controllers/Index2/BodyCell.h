//
//  BodyCell.h
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveData.h"
@class BodyCell;
@protocol BodyTableViewCellDelegate <NSObject>
@optional
-(void)request:(id)sender InCell:(BodyCell *)cell;
-(void)delet:(id)sender InCell:(BodyCell *)cell;
-(void)someoneDetailInCell:(BodyCell *)cell;
@end

@interface BodyCell : UITableViewCell
@property(nonatomic,retain)id<BodyTableViewCellDelegate>delegate;


@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIImageView *herad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableHeight;
@property (weak, nonatomic) IBOutlet UILabel *time;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableFarm;
@property (nonatomic,strong)NSMutableArray *data;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionviewHeight;
@property (weak, nonatomic) IBOutlet UIView *collectionview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionviewFarm;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deletFarm;
@property (nonatomic,strong) NSString *xid;
@property (nonatomic,strong) NSMutableArray *lableHeightArray;
@property (nonatomic,strong) NSMutableArray *cellHeightArray;

//-(void)setCellContent:(LiveData *)data;
- (IBAction)request:(id)sender;
- (IBAction)delet:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *deleteContent;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
