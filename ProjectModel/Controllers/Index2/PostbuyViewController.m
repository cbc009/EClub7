//
//  PostbuyViewController.m
//  Club
//
//  Created by MartinLi on 14-12-24.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PostbuyViewController.h"
#import "MLMutiImagesChoosenViewController.h"
#import "PostGood.h"
#import "SharedData.h"
#import "Member_Login.h"
@interface PostbuyViewController ()
{
    MLMutiImagesChoosenViewController *mutiImagesContoller;
    NSMutableArray *textFiledArray;
    PostGood *postGood;
}
@end

@implementation PostbuyViewController

-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidLoad {
    postGood = [[PostGood alloc] init];
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)postbuy:(id)sender {
    NSLog(@"%@",mutiImagesContoller.chooseImages);
//    SharedData *sharedData = [SharedData sharedInstance];
//    UserInfo *user= sharedData.user;
//    [postGood postGoodWithmid:user.mid andSid:user.sid andTitle:self.name.text andContent:self.content.text andDegree:self.newold.text andPrice:self.price.text andName:user.nickname andMobile:self.phone.text onViewController:self];

}
@end
