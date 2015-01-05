//
//  Index1ViewController.h
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MarqueeLabel.h>
#import "PrizeIndex.h"

@interface Index1ViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet MarqueeLabel *marqueeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property(nonatomic,strong)NSArray *rotatyCashes;
@property(nonatomic,strong)NSArray *rotaty;
@property(nonatomic,strong)PrizeIndexInfo *prizeIndexInfo;
-(void)setLabelWithRotary:(NSArray *)rotary;
@end
