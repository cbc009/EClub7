//
//  TouchIDAlidateViewController.h
//  Club
//
//  Created by Gao Huang on 15-3-4.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TouchIDSetDelegate <NSObject>

-(void)touchIDSetSuccessed;

@end

@interface TouchIDAlidateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)nextStep:(id)sender;
@property(nonatomic,weak)id<TouchIDSetDelegate> touchIDSetDelegagte;
@end
