//
//  KillIndex1_Cell.h
//  Club
//
//  Created by MartinLi on 15/5/21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KillIndex1_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sellerPic;
@property (weak, nonatomic) IBOutlet UILabel *sellername;
//@property (weak, nonatomic) IBOutlet UILabel *sellerDetail;
@property (weak, nonatomic) IBOutlet UIWebView *sellerDetails;
@end
