//
//  UPPayViewController.m
//  Club
//
//  Created by MartinLi on 15-1-22.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "UPPayViewController.h"
#import "UPPayPlugin.h"
#import <BmobSDK/Bmob.h>
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
    if ([result isEqualToString:@"success"]) {
        //存储到Bmob后台
        SharedData *sharedData = [SharedData sharedInstance];
        UserInfo *user = sharedData.user;
        BmobObject *object = [BmobObject objectWithClassName:@"Recharge"];
        [object setObject:user.loginname forKey:@"loginname"];
        [object setObject:@"UUPay" forKey:@"payType"];
        [object setObject:[NSNumber numberWithFloat:sharedData.createPayPrice] forKey:@"price"];
        [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            //进行操作
        }];
        
        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
    }else if([result isEqualToString:@"cancel"]){
        [SVProgressHUD showSuccessWithStatus:@"取消支付"];
    } else{
        [SVProgressHUD showSuccessWithStatus:@"支付失败"];
    }
}


@end
