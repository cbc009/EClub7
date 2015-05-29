//
//  RootTabBarViewController.m
//  Club
//
//  Created by MartinLi on 14-11-19.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "LoginViewController.h"
#import "AgentViewController.h"
#import "BuyService.h"
#import "Index0Service.h"
@interface RootTabBarViewController ()<UIAlertViewDelegate,LoginViewControllerDelegate,ChangeAgentIdDeleGate>

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *storyboard0 = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    UINavigationController *index0Nav = [storyboard0 instantiateViewControllerWithIdentifier:@"Index0NavViewController"];
//    UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:@"Index1" bundle:nil];
//    UINavigationController *index1Nav = [storyboard1 instantiateViewControllerWithIdentifier:@"Index1NavViewController"];
 
    UIStoryboard *storyboard2 = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
    UINavigationController *index2Nav = [storyboard2 instantiateViewControllerWithIdentifier:@"Index2NavViewController"];
    UIStoryboard *storyboard3 = [UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    UINavigationController *index3Nav = [storyboard3 instantiateViewControllerWithIdentifier:@"Index3Nav"];
 
    UIStoryboard *storyboard4 = [UIStoryboard storyboardWithName:@"Index4" bundle:nil];
    UINavigationController *index0Nav4 = [storyboard4 instantiateViewControllerWithIdentifier:@"Index4NavViewController"];
    
    [self addChildViewController:index0Nav];
//    [self addChildViewController:index1=Nav];
    [self addChildViewController:index0Nav4];
    [self addChildViewController:index2Nav];
    [self addChildViewController:index3Nav];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    
//}
//
//-(void) viewDidAppear:(BOOL)animated
//{
//    [self.selectedViewController endAppearanceTransition];
//}
//
//-(void) viewWillDisappear:(BOOL)animated
//{
//    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
//}
//
//-(void) viewDidDisappear:(BOOL)animated
//{
//    [self.selectedViewController endAppearanceTransition];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//tag=1 为余额不足tag =5 异地登陆 tag =6 游客进入然后跳转登陆
#pragma UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1){
        if (buttonIndex==1) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            UIViewController *target = [storyboard instantiateViewControllerWithIdentifier:@"CreatePayViewController"];
            target.hidesBottomBarWhenPushed = YES;
            self.selectedIndex = 0;
            UINavigationController *nav = self.viewControllers[self.selectedIndex];
            [nav pushViewController:target animated:YES];
        }
    }else if (alertView.tag==5) {
        if(buttonIndex==1){
            self.selectedIndex = 0;
            UINavigationController *nav = self.viewControllers[self.selectedIndex];
            [nav popToRootViewControllerAnimated:YES];
            [SharedAction loginAggane];
        }
    }else if (alertView.tag==6){
        if (buttonIndex==1) {
            [self.selectedViewController beginAppearanceTransition: YES animated:YES];
            self.selectedIndex=0;
            UINavigationController *nav = self.viewControllers[self.selectedIndex];
            [nav popToRootViewControllerAnimated:YES];
            [SharedAction presentLoginViewControllerInViewController:nav];
        }
    }
}

#pragma LoginViewControllerDelegate
-(void)loginSuccessedActionWithViewController:(UIViewController *)viewController{
     [self.selectedViewController beginAppearanceTransition: YES animated:YES];
        self.selectedIndex=0;
    [viewController.navigationController dismissViewControllerAnimated:YES completion:^{
        UINavigationController *nav = self.viewControllers[0];
        UIViewController *index0ViewController = nav.topViewController;
        SharedData *sharedData = [SharedData sharedInstance];
        Index0Service *index0Service = [Index0Service new];
//        [buyService loadGoodTypesWithToken:sharedData.user.token andUser_type:sharedData.user.user_type InViewController:index0ViewController];
        [index0Service loadAdverPicWithPos:1 andAgentID:sharedData.user.agent_id inViewController:index0ViewController];
    }];
}
-(void)changeAgentId:(NSString *)agentid{
    Index0Service *index0Service = [Index0Service new];
     SharedData *sharedData = [SharedData sharedInstance];
    [index0Service loadAdverPicWithPos:1 andAgentID:sharedData.user.agent_id inViewController:self];
    [index0Service loginIndexWithAgentId:sharedData.user.agent_id andLifeHallId:sharedData.user.lifehall_id inViewCOntroller:self];
    
    
}
@end
