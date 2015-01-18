//
//  PostContentViewController.m
//  Club
//
//  Created by MartinLi on 15-1-12.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PostContentViewController.h"
#import "LifecircleService.h"
#import "Status.h"
@interface PostContentViewController ()
{
    UserInfo *user;
}
@end

@implementation PostContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
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

- (IBAction)post:(id)sender {
    LifecircleService *lifecirleService = [[LifecircleService alloc] init];
    NSLog(@"%@",self.content.text);
    [lifecirleService LifecircleLifeCommentWithToken:user.token andUser_type:user.user_type andContent:self.content.text andXid:self.xid withTabBarController:self.tabBarController withDone:^(Status *model){

    }];
}
@end
