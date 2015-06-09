//
//  FeedRequestCell.h
//  
//
//  Created by MartinLi on 15-1-26.
//
//

#import <UIKit/UIKit.h>

@interface FeedRequestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *heard;
@property (weak, nonatomic) IBOutlet UIImageView *heard2;
@property (weak, nonatomic) IBOutlet UILabel *regtime;
@property (weak, nonatomic) IBOutlet UILabel *retime;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *request;
@property (weak, nonatomic) IBOutlet UIImageView *contentBack;
@property (weak, nonatomic) IBOutlet UIImageView *requestback;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBackHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *requestHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reauestWidth;


@end
