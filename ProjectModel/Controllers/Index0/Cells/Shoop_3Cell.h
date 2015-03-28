//
//  Shoop_3Cell.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Shoop_3Cell;
@protocol Shoop_3Delegate <NSObject>
-(void)pushRemarkWithsender:(id)sender inCell:(Shoop_3Cell*)cell;
@end
@interface Shoop_3Cell : UITableViewCell
@property(nonatomic,weak)id<Shoop_3Delegate>delegate;
- (IBAction)remark:(id)sender;

@end
