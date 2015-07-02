//
//  PostLifecircleViewController.m
//  Club
//
//  Created by MartinLi on 15-1-12.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PostLifecircleViewController.h"
#import "MLMutiImagesChoosenViewController.h"
#import "LifecircleService.h"
#import "Status.h"
@interface PostLifecircleViewController ()
{
     MLMutiImagesChoosenViewController *mutiImagesContoller;
    LifecircleService *lifecircleService;
    UserInfo *user;
}
@end

@implementation PostLifecircleViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    [self.content becomeFirstResponder];
    lifecircleService = [[LifecircleService alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MLMutiImagesViewController" bundle:nil];
    mutiImagesContoller = [storyboard instantiateViewControllerWithIdentifier:@"MLMutiImagesChoosenViewController"];
    mutiImagesContoller.fatherController = self;
    mutiImagesContoller.imageMode = getImagesMode;//（必选）
    mutiImagesContoller.superView = self.collectionview;
    mutiImagesContoller.collectionviewHeight = self.collectionviewHeight.constant;
    [self addChildViewController:mutiImagesContoller];
    [self.collectionview addSubview: mutiImagesContoller.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)post:(id)sender {
    if (self.content.text==nil||[self.content.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"输入内容不能为空"];
    }else{
        [lifecircleService lifecircleWitkToken:user.token andUser_Type:user.user_type withContent:self.content.text andImageArray:mutiImagesContoller.chooseImages withTabBarController:self.tabBarController withDone:^(Status *model){
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
}
@end
