//
//  NoticeCell.m
//  Club
//
//  Created by MartinLi on 15-4-17.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.marqueeLabel.marqueeType = MLContinuous;
    self.marqueeLabel.scrollDuration = 30.0f;
    self.marqueeLabel.fadeLength = 10.0f;
    self.marqueeLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.marqueeLabel addGestureRecognizer:tapRecognizer];
}
//暂停/开始滚动
- (void)pauseTap:(UITapGestureRecognizer *)recognizer {
    MarqueeLabel *continuousLabel2 = (MarqueeLabel *)recognizer.view;
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (!continuousLabel2.isPaused) {
            [continuousLabel2 pauseLabel];
        } else {
            [continuousLabel2 unpauseLabel];
        }
    }
}
@end
