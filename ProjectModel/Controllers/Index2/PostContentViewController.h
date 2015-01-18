//
//  PostContentViewController.h
//  Club
//
//  Created by MartinLi on 15-1-12.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (nonatomic,strong) NSString *xid;
- (IBAction)post:(id)sender;

@end
