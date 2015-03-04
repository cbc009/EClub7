//
//  TouchIDAlidateViewController.m
//  Club
//
//  Created by Gao Huang on 15-3-4.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "TouchIDAlidateViewController.h"
#import "TouchIDSetViewController.h"
@interface TouchIDAlidateViewController ()

@end

@implementation TouchIDAlidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.password resignFirstResponder];
    SharedData *sharedData = [SharedData sharedInstance];
    sharedData.fingerIsOpened = @"yes";
    sharedData.payPassword = self.password.text;
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.touchIDSetDelegagte touchIDSetSuccessed];

}
@end
