//
//  RootTabBarViewController.m
//  Club
//
//  Created by MartinLi on 14-11-19.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "LoginViewController.h"
#import "BuyService.h"
#import "Index0Service.h"
@interface RootTabBarViewController ()<UIAlertViewDelegate,LoginViewControllerDelegate>

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *storyboard0 = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    UINavigationController *index0Nav = [storyboard0 instantiateViewControllerWithIdentifier:@"Index0NavViewController"];
    UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:@"Index1" bundle:nil];
    UINavigationController *index1Nav = [storyboard1 instantiateViewControllerWithIdentifier:@"Index1NavViewController"];
 
    UIStoryboard *storyboard2 = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
    UINavigationController *index2Nav = [storyboard2 instantiateViewControllerWithIdentifier:@"Index2NavViewController"];
    UIStoryboard *storyboard3 = [UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    UINavigationController *index3Nav = [storyboard3 instantiateViewControllerWithIdentifier:@"Index3Nav"];
    [self addChildViewController:index0Nav];
    [self addChildViewController:index1Nav];
    [self addChildViewController:index2Nav];
    [self addChildViewController:index3Nav];
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

#pragma UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==5) {
        if(buttonIndex==1){
            self.selectedIndex = 0;
            UINavigationController *nav = self.viewControllers[self.selectedIndex];
            [nav popToRootViewControllerAnimated:YES];
            [SharedAction loginAggane];
        }
    }else if (alertView.tag==1){
        if (buttonIndex==1) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            UIViewController *target = [storyboard instantiateViewControllerWithIdentifier:@"CreatePayViewController"];
            target.hidesBottomBarWhenPushed = YES;
            self.selectedIndex = 0;
            UINavigationController *nav = self.viewControllers[self.selectedIndex];
            [nav pushViewController:target animated:YES];
        }
    }else if (alertView.tag==6){
        if (buttonIndex==1) {
            self.selectedIndex = 0;
            UINavigationController *nav = self.viewControllers[self.selectedIndex];
            [nav popToRootViewControllerAnimated:YES];
            [SharedAction presentLoginViewControllerInViewController:nav];
            NSLog(@"dddd");
        }
    }
}

#pragma LoginViewControllerDelegate
-(void)loginSuccessedActionWithViewController:(UIViewController *)viewController{
    self.selectedIndex = 0;
    [viewController.navigationController dismissViewControllerAnimated:YES completion:^{
        UINavigationController *nav = self.viewControllers[0];
        UIViewController *index0ViewController = nav.topViewController;
        SharedData *sharedData = [SharedData sharedInstance];
        BuyService *buyService = [[BuyService alloc] init];
        Index0Service *index0Service = [Index0Service new];
        [buyService loadGoodTypesWithToken:sharedData.user.token andUser_type:sharedData.user.user_type InViewController:index0ViewController];
        [index0Service loadAdverPicWithPos:1 andCity:sharedData.user.city inViewController:index0ViewController];
    }];
    
}
@end
