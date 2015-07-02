//
//  ChangeNameViewController.h
//  Club
//
//  Created by MartinLi on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
@interface ChangeNameViewController : UIViewController<UIKeyboardViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *newname;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *save;
- (IBAction)saveActions:(id)sender;
- (IBAction)deleteAction:(id)sender;


@end
