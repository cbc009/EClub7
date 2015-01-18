//
//  PostLifecircleViewController.h
//  Club
//
//  Created by MartinLi on 15-1-12.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostLifecircleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *collectionview;
@property (weak, nonatomic) IBOutlet UITextView *content;
- (IBAction)post:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionviewHeight;
@end
