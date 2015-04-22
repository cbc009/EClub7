//
//  SellerOrderCell.h
//  Club
//
//  Created by MartinLi on 15-4-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SellerOrderCell;
@protocol SellerOderDeleGate<NSObject>
-(void)backGoods:(id)sender InCell:(SellerOrderCell*)cell;
@end
@interface SellerOrderCell : UITableViewCell
@property(nonatomic,retain)id<SellerOderDeleGate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
- (IBAction)backGoods:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backGood;

@end
