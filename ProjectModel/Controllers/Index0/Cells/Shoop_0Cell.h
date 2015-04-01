//
//  Shoop_0Cell.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Shoop_0Cell;
@protocol Shoop0Delegate <NSObject>
-(void)downWithSender:(id)sender inCell:(Shoop_0Cell *)cell;
@end
@interface Shoop_0Cell : UITableViewCell
@property (nonatomic,weak)id<Shoop0Delegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *sellerName;
@property (weak, nonatomic) IBOutlet UILabel *totle;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dones;

@end
