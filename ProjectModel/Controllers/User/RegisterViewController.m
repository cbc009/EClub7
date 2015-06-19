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
#import "NSString+MT.h"
#import "Status.h"
@interface RegisterViewController ()<UIAlertViewDelegate>
{
    __weak IBOutlet UITextField *loginname;
    __weak IBOutlet UITextField *code;
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UITextField *Passwd;
    __weak IBOutlet UITextField *guide;
    NSTimer *timer;
    RegisterService *registerService;
    UIKeyboardViewController *keyBoardController;
    NSInteger countDownSecond;
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
    [registerService sendCodeACtionWithLoginname:name inTabBarController:self.tabBarController withDone:^(Status *model){
        if (model.status==802) {
            UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"用户已存在" message:@"该手机已注册请直接登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在去登录", nil];
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            [alertView show];
        }else{
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
            countDownSecond=50;
        }
    }];
}

-(void)countDownTimer{
    if (countDownSecond>0) {
        countDownSecond--;
        [self.time setTitle:[NSString stringWithFormat:@"%ld",(long)countDownSecond] forState:UIControlStateNormal];
    }else{
        [timer invalidate];
        [self.time setTitle:@"发送" forState:UIControlStateNormal];
    }
}

- (IBAction)registerAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    ChooseAreaViewController *chooseAreaViewController = [storyboard instantiateViewControllerWithIdentifier:@"ChooseAreaViewController"];
    chooseAreaViewController.loginname=loginname.text;
    chooseAreaViewController.password1=password.text;
    chooseAreaViewController.password2 = Passwd.text;
    chooseAreaViewController.code = code.text;
    chooseAreaViewController.guide = guide.text;
    NSString *phone =loginname.text;
    if ([loginname.text isEqualToString:@""]||[password.text isEqualToString:@""]||[Passwd.text isEqualToString:@""]||[code.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入完整信息!"];
        return;
    }else if (password.text.length<6){
        [SVProgressHUD showErrorWithStatus:@"至少需要输入大于六位密码!"];
        return;
    }else if (code.text.length<4){
        [SVProgressHUD showErrorWithStatus:@"请输入完整验证码!"];
        return;
    }else if (![phone isValidateMobile:phone]){
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号!"];
        return;
    }
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
