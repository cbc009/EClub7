//
//  CallPhoneTopupViewController.h
//  Club
//
//  Created by MartinLi on 15-1-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallPhoneTopupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneMobile;

@property (weak, nonatomic) IBOutlet UITextField *times;
- (IBAction)recharge:(id)sender;

@end
