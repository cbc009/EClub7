//
//  FeedBackCell.h
//  Club
//
//  Created by MartinLi on 15-1-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FeedBackCell;
@protocol FeedbackDelegate <NSObject>
@optional
-(void)feedbackInCell:(FeedBackCell *)cell;
@end
@interface FeedBackCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *myFeedback;
@property (nonatomic,retain)id<FeedbackDelegate>delegate;
- (IBAction)goGo:(id)sender;

@end
