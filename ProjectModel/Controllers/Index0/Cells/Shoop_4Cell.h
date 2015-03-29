//
//  Shoop_4Cell.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Shoop_4Cell;
@class Request_0Cell;
@protocol Shoop4CellDelegate <NSObject>
-(void)likeWithSender:(id)sender inCell:(Shoop_4Cell*)cell;
-(void)remarkWithSender:(id)sender inCell:(Shoop_4Cell*)cell;
-(void)replyWithRegid:(NSString *)regid andRegName:(NSString *)regName andOtherName:(NSString *)otherName inCell:(Shoop_4Cell*)cell;
@end
@interface Shoop_4Cell : UITableViewCell
@property (weak,nonatomic)id<Shoop4CellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *heardPic;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topicHeight;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (strong,nonatomic)NSMutableArray *datas;
- (IBAction)remark:(id)sender;
- (IBAction)like:(id)sender;

@end
