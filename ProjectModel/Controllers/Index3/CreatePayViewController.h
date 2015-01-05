//
//  CreatePayViewController.h
//  Club
//
//  Created by Gao Huang on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreatePayViewDelegate <NSObject>

-(void)reloadAmount;

@end

@interface CreatePayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *price;
@property(nonatomic,weak)id<CreatePayViewDelegate> delegate;
@end
