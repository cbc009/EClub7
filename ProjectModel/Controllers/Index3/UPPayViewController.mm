//
//  UPPayViewController.m
//  Club
//
//  Created by MartinLi on 15-1-22.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "UPPayViewController.h"
#import "UPPayPlugin.h"
@interface UPPayViewController ()

@end

@implementation UPPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.tnMode = kMode_Development;
    [UPPayPlugin startPay:self.tn mode:self.tnMode viewController:self delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:kResult,result];
    [SVProgressHUD showSuccessWithStatus:msg];
}


@end
