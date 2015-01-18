//
//  QRCodeViewController.m
//  Club
//
//  Created by dongway on 14-8-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "QRCodeViewController.h"
#import "SharedData.h"
#import "Member_Login.h"
#import <UIImageView+WebCache.h>
#import "QRCodeGenerator.h"
#import "UserDefaults.h"
@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UserDefaults *userDefaults = [[UserDefaults alloc] init];
    // Do any additional setup after loading the view.
    self.title = @"我的二维码";
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    
    NSString *value = [userDefaults.userDefaults1 objectForKey:@"nickname"];
    if (value==0) {
        self.name.text = user.nickname;
    }
    else {
        self.name.text = value;
    }
//    self.address.text = user.sname;
    self.QRImgView.image = [QRCodeGenerator qrImageForString:sharedData.password imageSize:self.QRImgView.frame.size.width];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.picture]]  placeholderImage:[UIImage imageNamed:@"e"]];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
