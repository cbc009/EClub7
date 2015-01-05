//
//  ChangeNameViewController.m
//  Club
//
//  Created by MartinLi on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ChangeNameViewController.h"
#import "ChangeUserNameService.h"
#import "UserDetailViewController.h"

#import "SVProgressHUD.h"

@interface ChangeNameViewController ()
{
    ChangeUserNameService *changeUserName;
    UserDetailViewController *user;
    UIKeyboardViewController *keyBoardController;

}

@end

@implementation ChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    changeUserName = [[ChangeUserNameService alloc] init];
    user = [[UserDetailViewController alloc] init];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)OK:(id)sender {
    NSString *nicname = _newname.text;
    [SVProgressHUD show];
   
    [changeUserName ChangeUserNameService:nicname onChangeNameViewcontroller:self];
    
    
}
@end
