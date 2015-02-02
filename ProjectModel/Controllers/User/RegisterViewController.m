//
//  RegisterViewController.m
//  Club
//
//  Created by dongway on 14-8-10.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterService.h"
#import "Index1Service.h"
#import "ChooseAreaViewController.h"
@interface RegisterViewController ()<UIAlertViewDelegate>
{
    __weak IBOutlet UITextField *loginname;
    __weak IBOutlet UITextField *code;
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UITextField *Passwd;
    __weak IBOutlet UITextField *guide;
    RegisterService *registerService;
    UIKeyboardViewController *keyBoardController;
}
@end

@implementation RegisterViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        registerService = [[RegisterService alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendCodeAction:(id)sender {
    NSString *name = loginname.text;
    [registerService sendCodeActionWithLoginname:name onViewController:self];
}


- (IBAction)registerAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    ChooseAreaViewController *chooseAreaViewController = [storyboard instantiateViewControllerWithIdentifier:@"ChooseAreaViewController"];
    chooseAreaViewController.loginname=loginname.text;
    chooseAreaViewController.password1=password.text;
    chooseAreaViewController.password2 = Passwd.text;
    chooseAreaViewController.code = code.text;
    chooseAreaViewController.guide = guide.text;
    if ([password.text isEqualToString:Passwd.text]) {
        [self.navigationController pushViewController:chooseAreaViewController animated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不相同请重新输入"];
        return ;
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
       [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)checkProtocolAction:(id)sender {
    self.checkButton.tag = -self.checkButton.tag;
    if (self.checkButton.tag==1) {
        [self.checkButton setImage:[UIImage imageNamed:@"checked_true.png"] forState:UIControlStateNormal];
    }else if(self.checkButton.tag == -1){
        [self.checkButton setImage:[UIImage imageNamed:@"checked_false.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)readProtocolAction:(id)sender {
    Index1Service *service = [[Index1Service alloc] init];
    [service loadWebViewWithURLString:ProtocolURL andTitle:@"服务协议" onViewContrller:self];
}


@end
