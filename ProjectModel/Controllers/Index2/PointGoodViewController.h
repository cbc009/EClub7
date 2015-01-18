//
//  PointGoodViewController.h
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointGoodViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;

@property (weak, nonatomic) IBOutlet UILabel *ePrize;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (assign ,nonatomic) NSInteger gid;
@property (assign ,nonatomic) NSInteger goods_num;
@property (strong ,nonatomic) NSArray *datas;
@property (strong ,nonatomic) NSDictionary *dict;
- (IBAction)Add:(id)sender;
- (IBAction)Releas:(id)sender;

- (IBAction)addGood:(id)sender;

@end
