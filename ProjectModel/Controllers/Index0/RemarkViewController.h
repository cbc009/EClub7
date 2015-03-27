//
//  RemarkViewController.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
@interface RemarkViewController : UIViewController
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *backScrollers;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextView *mTextview;
@property (weak, nonatomic) IBOutlet UILabel *index0;
@property (weak, nonatomic) IBOutlet UILabel *index1;
@property (weak, nonatomic) IBOutlet UILabel *index2;
@property (weak, nonatomic) IBOutlet UILabel *index3;

@end
