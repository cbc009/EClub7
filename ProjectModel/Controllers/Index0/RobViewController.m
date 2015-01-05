//
//  
//  Club
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RobViewController.h"
#import "PastItemsTableViewController.h"
#import "RobedRecordsTableViewController.h"
#import "RobService.h"
#import "SharedData.h"
#import "Login.h"
#import "NSString+MT.h"
#import "SharedAction.h"
#import "WebViewController.h"
#import "Status.h"
@interface RobViewController ()
{
    
    RobService *robService;
    UserInfo *user;
        int count;
}
@end

@implementation RobViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.title = @"免费抢";
    robService = [[RobService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    //给 self.robModel
    [robService setRobModelWithToken:user.token andUser_type:user.user_type withDoneAndStatus:^(int status,RobModel *model){
        [SharedAction showErrorWithStatus:status witViewController:self];
        [robService setItemInfosWithController:self andGoodModel:model.info];
        [robService loadAdverPicWithPos:1 inViewController:self];
    }];
    
   
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"robRecords"]) {
        //抢菜记录
//        RobedRecordsTableViewController *viewController = segue.destinationViewController;
//        [robService loadRecordsInRecordsController:viewController];
    }else if([segue.identifier isEqualToString:@"pastItems"]){
}
}

//抢
- (IBAction)buyOrRobAction:(id)sender {
    [robService robWithToken:user.token andUser_type:user.user_type andRobModel:self.robModel witDoneAndObject:^(int status,Status *model){
        if (status==2) {
            SharedData *sharedData = [SharedData sharedInstance];
            UserInfo *user = sharedData.user;
            if ([self.robModel.point isEqualToString:@""]) {
                user.amount = user.amount -[self.robModel.discount floatValue];
            }else {
                user.point = user.point -[self.robModel.point integerValue];
            }
            NSString *message =[NSString stringWithFormat:@"恭喜你在E小区免费抢到%@赶快去告诉朋友吧",self.robModel.name];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抢菜信息" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去告诉朋友", nil];
            [alertView show];
        }else{
            [SharedAction showErrorWithStatus:status witViewController:self];
        }
    }];
    
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daojishi:) userInfo:nil repeats:YES];
}

#pragma MartinLiPageScrollViewDelegate
-(void)imgViewDidTouchActionAtIndex:(NSInteger)index inArray:(NSArray *)array{
    NSString *url = array[index];
    if ([url  hasPrefix:@"http"]) {
        WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        target.urlString = url;
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }else{
        NSLog(@"暂无url");
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==5) {
        if(buttonIndex==1){
            [SharedAction loginAggane];
            NSArray *viewControllers = self.navigationController.viewControllers;
            [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];

        }
    }else{
        if(buttonIndex==1) {
        [SharedAction shareWithTitle:_itemNameLabel.text andDesinationUrl:AppDownLoadURL Text:alertView.message andImageUrl:_itemPic InViewController:self];
    }
    }
}
- (IBAction)shareAction:(id)sender {
    [SharedAction shareWithTitle:_itemNameLabel.text andDesinationUrl:AppDownLoadURL Text:@"在E小区中每天都有免费抢菜哦 小伙伴们赶快来" andImageUrl:_itemPic InViewController:self];
}

@end
