//
//  ChangeAdressViewController.m
//  Club
//
//  Created by MartinLi on 14-11-14.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ChangeAdressViewController.h"
#import "ChangeAddressService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "UserDefaults.h"
#import "Status.h"
@interface ChangeAdressViewController ()
{
    ChangeAddressService *changeAddressService;
    UserDefaults *userDefaults ;
      UIKeyboardViewController *keyBoardController;
    UserInfo *user;
}

@end

@implementation ChangeAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    self.title = @"修改地址";
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    _newaddress.text =user.address;
    [self.newaddress becomeFirstResponder];
    changeAddressService = [[ChangeAddressService alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)save:(id)sender {
    NSString *adress= _newaddress.text;
    [changeAddressService changeAddressService:adress withToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withdone:^(Status *model){
        user.address = self.newaddress.text;
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
@end
