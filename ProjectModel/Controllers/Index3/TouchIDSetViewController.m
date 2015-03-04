//
//  TouchIDSetViewController.m
//  Club
//
//  Created by Gao Huang on 15-3-4.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "TouchIDSetViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDSetViewController ()

@end

@implementation TouchIDSetViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SharedData *sharedData = [SharedData sharedInstance];
    if ([sharedData.fingerIsOpened isEqualToString:@"yes"]) {
        [self.switchButton setOn:YES animated:YES];
    }else{
        [self.switchButton setOn:NO animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)switch:(UISwitch *)sender {
    if(sender.on==YES){
        LAContext *myContext = [[LAContext alloc] init];
        myContext.localizedFallbackTitle = @"";//设置为nil，则不会出现“输入密码”
        NSError *authError = nil;
        NSString *myLocalizedReasonString = @"请验证已有指纹";

        if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
            [SVProgressHUD show];

            [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                      localizedReason:myLocalizedReasonString
                                reply:^(BOOL succes, NSError *error) {
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        if (succes) {
                                            
                                            TouchIDAlidateViewController *target = [self.storyboard instantiateViewControllerWithIdentifier:@"TouchIDAlidateViewController"];
                                            target.touchIDSetDelegagte = self;
                                            [self.navigationController pushViewController:target animated:YES];
                                            [SVProgressHUD dismiss];
                                        } else {
                                            
                                            switch (error.code) {
                                                case LAErrorAuthenticationFailed:
                                                    [SVProgressHUD showErrorWithStatus:@"身份认证失败"];
                                                    break;
                                                    
                                                case LAErrorUserCancel:
                                                    [SVProgressHUD showErrorWithStatus:@"身份认证取消"];
                                                    break;
                                                    
                                                default:
                                                    [SVProgressHUD showErrorWithStatus:@"touch ID 尚未设置"];
                                                    break;
                                            }
                                            [SVProgressHUD showErrorWithStatus:@"身份认证失败"];
                                            
                                            [sender setOn:NO animated:YES];
                                            
                                        }
                                    });
                                    
                                    
                                }];
        } else {
            [SVProgressHUD showErrorWithStatus:@"本设备不支持指纹识别"];
            [sender setOn:NO animated:YES];
        }

    }else if(sender.on==NO){
        SharedData *sharedData = [SharedData sharedInstance];
        sharedData.fingerIsOpened = @"no";
        sharedData.password = @"";
    }
}

#pragma TouchIDSetDelegate
-(void)touchIDSetSuccessed{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"指纹密码设置成功" message:@"恭喜，您的指纹可用于支付" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道了", nil];
    [alertView show];
    
}
@end
