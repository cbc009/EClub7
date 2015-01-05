//
//  PostbuyViewController.h
//  Club
//
//  Created by MartinLi on 14-12-24.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostbuyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *newold;
@property (weak, nonatomic) IBOutlet UITextView *content;
- (IBAction)postbuy:(id)sender;

@end
