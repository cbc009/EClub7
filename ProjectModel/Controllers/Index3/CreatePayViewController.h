//
//  CreatePayViewController.h
//  Club
//
//  Created by Gao Huang on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
enum{
    ailpayType,
    UPPayType,
    WeiPayType,
};

@interface CreatePayViewController : UIViewController
- (IBAction)alipay:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ali;
- (IBAction)uppay:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *upaypay;
- (IBAction)weipay:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *weipaypay;
@property (weak, nonatomic) IBOutlet UITextField *price;
@end
