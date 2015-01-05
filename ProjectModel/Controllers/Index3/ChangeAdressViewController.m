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
#import "Login.h"
#import "UserDefaults.h"
@interface ChangeAdressViewController ()
{
    ChangeAddressService *changeAddressService;
    UserDefaults *userDefaults ;
      UIKeyboardViewController *keyBoardController;
}

@end

@implementation ChangeAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    self.title = @"修改地址";
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    _newaddress.placeholder =user.address;
    changeAddressService = [[ChangeAddressService alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



- (IBAction)go:(id)sender {
    NSString *adress= _newaddress.text;

    [changeAddressService ChangeAddressService:adress onChangeAdressViewController:self];
   
}
@end
