//
//  LoginViewController.m
//  Club
//
//  Created by dongway on 14-8-10.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginService.h"
#import "ChooseAreaViewController.h"

@interface LoginViewController ()
{
    __weak IBOutlet UITextField *loginname;
    __weak IBOutlet UITextField *password;
    LoginService *loginService;
    UIKeyboardViewController *keyBoardController;
}
@end

@implementation LoginViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        loginService = [[LoginService alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    loginname.text = self.loginname1;
    loginname.keyboardType=UIKeyboardTypeNumberPad;
    password.text = self.password1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)loginAction:(id)sender {
    NSString *name = loginname.text;
    NSString *passwd = password.text;
    [loginService loginWithName:name andPasswd:passwd onViewController:self];
}
- (IBAction)registerAction:(id)sender {
    [loginService pushRegisterViewControllerOnViewController:self];
}
- (IBAction)forgetPassword:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请带有效证件到小区生活馆找回密码!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}


- (IBAction)dismissAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
