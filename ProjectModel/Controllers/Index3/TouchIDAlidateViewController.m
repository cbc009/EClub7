//
//  TouchIDAlidateViewController.m
//  Club
//
//  Created by Gao Huang on 15-3-4.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "TouchIDAlidateViewController.h"
#import "TouchIDSetViewController.h"
#import "Status.h"
#import "MyMD5.h"
@interface TouchIDAlidateViewController ()
{
    UserInfo *user;
}
@end

@implementation TouchIDAlidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    // Do any additional setup after loading the view.
    [self.password becomeFirstResponder];
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

- (IBAction)nextStep:(id)sender {
    NSString *passwd2 = [MyMD5 md5:self.password.text];
    [SharedAction confirmPssswordWithToken:user.token andUser_type:user.user_type andType:@"2" andPassword:passwd2 inTabBarController:self.tabBarController withDone:^(Status *model){
        if (model.status==2) {
            [self.password resignFirstResponder];
            SharedData *sharedData = [SharedData sharedInstance];
            sharedData.fingerIsOpened = @"yes";
            sharedData.payPassword = self.password.text;
            [self.navigationController popViewControllerAnimated:YES];
            [self.touchIDSetDelegagte touchIDSetSuccessed];
        }
    }];
    

}

@end
