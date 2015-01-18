//
//  PostViewController.h
//  Club
//
//  Created by MartinLi on 14-12-21.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PostViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *collectionview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionviewHeight;
//- (IBAction)post:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *newold;
@property (weak, nonatomic) IBOutlet UITextView *content;
- (IBAction)segment:(UISegmentedControl *)sender;


@end
