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
#import "Member_Login.h"
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
    self.title = @"抢购";
    robService = [[RobService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    //给 self.robModel
    __block RobViewController *aBlockSelf = self;
    __block RobService *rob = robService;
    [robService setRobModelWithToken:user.token andUser_type:user.user_type inRootTabBarController:self.tabBarController withDone:^(RobModel *model){
        [rob setItemInfosWithController:aBlockSelf andGoodModel:model.info];
        [rob loadAdverPicWithPos:1 inViewController:aBlockSelf];
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
    [robService robWithToken:user.token andUser_type:user.user_type andRobModel:self.robModel inTabBarController:self.tabBarController withDone:^(Status *model){
        if ([self.robModel.point isEqualToString:@""]) {
            user.amount = user.amount -[self.robModel.discount floatValue];
        }else {
            user.point = user.point -[self.robModel.point integerValue];
        }
        NSString *message =[NSString stringWithFormat:@"恭喜你在E小区免费抢到%@赶快去告诉朋友吧",self.robModel.name];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抢菜信息" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去告诉朋友", nil];
        [alertView show];
    }];
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
    if(buttonIndex==1) {
        [SharedAction shareWithTitle:_itemNameLabel.text andDesinationUrl:AppDownLoadURL Text:alertView.message andImageUrl:_itemPic InViewController:self];
    }
}

- (IBAction)shareAction:(id)sender {
    [SharedAction shareWithTitle:_itemNameLabel.text andDesinationUrl:AppDownLoadURL Text:@"在E小区中每天都有免费抢菜哦 小伙伴们赶快来" andImageUrl:_itemPic InViewController:self];
}

@end
