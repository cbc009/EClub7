//
//  ChangeAdressViewController.h
//  Club
//
//  Created by MartinLi on 14-11-14.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
@interface ChangeAdressViewController : UIViewController<UIKeyboardViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *newaddress;
- (IBAction)go:(id)sender;

@end
