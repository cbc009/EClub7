//
//  CallPhoneTopupViewController.m
//  Club
//
//  Created by MartinLi on 15-1-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "CallPhoneTopupViewController.h"
#import "CallService.h"
#import "Status.h"
#import <SVProgressHUD.h>
#import "NSString+MT.h"
@interface CallPhoneTopupViewController ()<UIAlertViewDelegate>
{
    CallService *callService;
    UserInfo *user;
}
@end

@implementation CallPhoneTopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"E电话充值";
    callService = [[CallService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    user=sharedData.user;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.phoneMobile.text=user.mobile;
    [self.times becomeFirstResponder];
    // Do any additional setup after loading the view.
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

- (IBAction)recharge:(id)sender {
    NSString *phone =self.phoneMobile.text;
    if ([phone isEqual:@""]||self.phoneMobile.text==nil) {
            [SVProgressHUD showErrorWithStatus:@"输入的手机号码不能为空"];
    }else if(![phone isValidateMobile:phone]){
        [SVProgressHUD showErrorWithStatus:@"手机号码不合法"];
    }else if(self.times.text==nil||[self.times.text isEqual:@""]){
          [SVProgressHUD showErrorWithStatus:@"输入的手机号码不能为空"];
    }else{
        CGFloat times = [self.times.text integerValue]*0.06;
        NSString *money = [NSString stringWithFormat:@"%0.2f",times];
        NSString *message = [NSString stringWithFormat:@"您将为%@充值%@分钟,需要支付%@元",phone,self.times.text,money];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"话费充值" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alertView show];
    
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
 if(buttonIndex==1){
        [callService callPhoneTopupWithToken:user.token andUser_type:user.user_type andMobile:self.phoneMobile.text andMinutes:self.times.text inTabBarcontroller:self.tabBarController withDone:^(Status *model){
            [self.navigationController popToRootViewControllerAnimated:YES];
    }];
 }
}
@end
