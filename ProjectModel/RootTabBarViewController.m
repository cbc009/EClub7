//
//  RootTabBarViewController.m
//  Club
//
//  Created by MartinLi on 14-11-19.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RootTabBarViewController.h"

@interface RootTabBarViewController ()

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

@end
