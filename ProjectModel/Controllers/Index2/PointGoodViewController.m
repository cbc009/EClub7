//
//  PointGoodViewController.m
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PointGoodViewController.h"
#import "PointGoodViewControllerService.h"
#import "Status.h"
#import <UIImageView+WebCache.h>
@interface PointGoodViewController ()<UIAlertViewDelegate>
{
    NSInteger sum;
    UserInfo *user;
    PointGoodViewControllerService *pointGoodViewControllerService;
}
@end

@implementation PointGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品兑换详情";
    pointGoodViewControllerService = [[PointGoodViewControllerService alloc] init];
    self.title = [self.dict valueForKey:@"name"];
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,[self.dict valueForKey:@"bigpicture"]]] placeholderImage:[UIImage imageNamed:@"e"]];
    self.ePrize.text = [NSString stringWithFormat:@"%@/份",[self.dict valueForKey:@"point"]];;
    self.gid = [[self.dict valueForKey:@"gid"]integerValue];
    sum = 1;
    self.num.text = [NSString stringWithFormat:@"%ld",(long)sum];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==3) {
        if(buttonIndex==1){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }else if (alertView.tag==4){
        if(buttonIndex == 1){
        [self payWithAletView:alertView];
         }
    }else {
       if(buttonIndex == 1){
        [self payWithAletView:alertView];
       }
    }
}
-(void)payWithAletView:(UIAlertView *)aletView
{
    __block PointGoodViewController *blockSelf =self;
     NSString *password = [[aletView textFieldAtIndex:0] text];
    [pointGoodViewControllerService addOderINPointGoodWithToken:user.token andUser_type:user.user_type andGId:self.gid andNus:self.num.text andPassword:password inTabBarController:self.tabBarController withDone:^(id model){
        NSNumber *stat = (NSNumber *)[model objectForKey:@"status"];
        NSInteger status2 = [stat integerValue];
        if (status2==806) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"密码错误" message:@"支付密码错误请重新输入" delegate:blockSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag=4;
            alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alertView show];
            return;
        }else{
            UIAlertView *aletview=[[UIAlertView alloc]initWithTitle:@"兑换成功" message:@"购买成功请及时到生活馆领取" delegate:blockSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            aletview.tag=3;
            [aletview show];
        }
    }];
}
- (IBAction)Add:(id)sender {
    sum ++;
    self.num.text = [NSString stringWithFormat:@"%ld",(long)sum];
}

- (IBAction)Releas:(id)sender {
    if (sum<1) {
        sum = 0;
    }else {
    sum --;
    self.num.text = [NSString stringWithFormat:@"%ld",(long)sum];
    }
}
- (IBAction)addGood:(id)sender {
    NSInteger totalPoint = [self.num.text integerValue]* [self.ePrize.text integerValue];
    NSString *message = [NSString stringWithFormat:@"您即将支付%ld积分购买%@,支付密码为手机号码后六位",(long)totalPoint,self.title];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认支付" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alertView show];
}
@end
