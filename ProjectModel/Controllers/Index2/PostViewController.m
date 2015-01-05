//
//  PostViewController.m
//  Club
//
//  Created by MartinLi on 14-12-21.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PostViewController.h"
#import "PostGood.h"
#import "SharedData.h"
#import "Login.h"
#import "MLMutiImagesChoosenViewController.h"
#import "SVProgressHUD.h"
#import "PostbuyViewController.h"
@interface PostViewController ()
{
    MLMutiImagesChoosenViewController *mutiImagesContoller;
    NSMutableArray *textFiledArray;
       PostGood *postGood;
    PostbuyViewController *postBuy;
}
@end

@implementation PostViewController


-(void)loadView{
    [super loadView];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MLMutiImagesViewController" bundle:nil];
    mutiImagesContoller = [storyboard instantiateViewControllerWithIdentifier:@"MLMutiImagesChoosenViewController"];
    mutiImagesContoller.fatherController = self;
    mutiImagesContoller.imageMode = getImagesMode;//（必选）
    mutiImagesContoller.superView = self.collectionview;
    mutiImagesContoller.collectionviewHeight = self.collectionviewHeight.constant;
    [self addChildViewController:mutiImagesContoller];
    [self.collectionview addSubview: mutiImagesContoller.collectionView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidLoad {
    postGood = [[PostGood alloc] init];
    [super viewDidLoad];
   
}


- (IBAction)post:(id)sender {
    NSLog(@"%@",mutiImagesContoller.chooseImages);
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user= sharedData.user;
    [postGood postGoodWithmid:user.mid andSid:user.sid andTitle:self.name.text andContent:self.content.text andDegree:self.newold.text andPrice:self.price.text andName:user.nickname andMobile:self.phone.text andImageArray:mutiImagesContoller.chooseImages onViewController:self];
}

- (IBAction)segment:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex==1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
        postBuy = [storyboard instantiateViewControllerWithIdentifier:@"PostbuyViewController"];
        [self addChildViewController:postBuy];
        [self.view addSubview:postBuy.view];
    
    }else{
        [postBuy.view removeFromSuperview];
        [postBuy removeFromParentViewController];
    }
}
@end
