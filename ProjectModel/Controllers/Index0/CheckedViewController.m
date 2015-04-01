//
//  CheckedViewController.m
//  Club
//
//  Created by MartinLi on 15-3-27.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "CheckedViewController.h"
#import "CheckCell.h"
#import "CheckService.h"
#import "NSString+MT.h"
#import "MyMD5.h"
#import "Status.h"
#import "SelectItemsTableViewController.h"
@interface CheckedViewController ()<UIAlertViewDelegate,SelectedItemsTableViewControllerDelegate>
{
    NSInteger type;//0买家自提1送货上门
    NSInteger type1;//1使用红包支付0使用账户余额支付
    UserInfo *user;
    CheckService *checkService;
}
@end

@implementation CheckedViewController

- (void)viewDidLoad {
    type=0;
    type1=0;
    [super viewDidLoad];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    checkService =[CheckService new];
    self.mone.text=[NSString stringWithFormat:@"使用账户余额:  ￥%0.2f",user.amount];
    self.redBag.text=[NSString stringWithFormat:@"使用红包余额:  ￥%0.2f",user.amount_red];
    [self.buyselfs setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
    [self.buyMones setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];

    self.title=@"订单确认";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CheckCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CheckCell" forIndexPath:indexPath];
    cell.goodname.text=self.models.goods_name;
    cell.numbs.text=self.numbs;
    cell.price.text=self.models.discount;
    CGFloat totlPrice=[self.models.discount floatValue] *[self.numbs integerValue];
    cell.totlPrice.text=[NSString stringWithFormat:@"%0.2f",totlPrice];
    self.totlePrice.text=[NSString stringWithFormat:@"%0.2f",totlPrice];
    self.timeArray=self.models.send_time;
    [self.send_time setTitle:self.timeArray[0] forState:UIControlStateNormal];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (IBAction)buySelf:(id)sender {
    type=0;

    [self.buyselfs setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
    [self.buyOthers setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
    
}
- (IBAction)buyOther:(id)sender {
    type=1;
    [self.buyselfs setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
    [self.buyOthers setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
}
- (IBAction)buyRed:(id)sender {
    type1=1;
    [self.buyMones setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
    [self.buyReds setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];

}

- (IBAction)buyMone:(id)sender {
    type1=0;
     [self.buyMones setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
    [self.buyReds setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];

}
- (IBAction)buyNow:(id)sender {
    if (user.user_type==3) {
        [SVProgressHUD showErrorWithStatus:@"请前往 “我”页面中的“个人信息”“关联区域”完善资料"];
    }else{
        [self submitAction];
    }
}
-(void)submitAction{
//    if([finalConfirmService compareCurrentTimeWithTime:@"21:30:00"] == NSOrderedDescending && [finalConfirmService compareCurrentTimeWithTime:@"06:00:00"] == NSOrderedAscending){
        //如果是卖家送货
        if (type==1) {
            if ([self.address.text isEqualToString:@""]) {
                [SVProgressHUD showErrorWithStatus:@"请填写准确送货地址"];
                return;
            }else if(![self.phone.text isValidateMobile:self.phone.text]){
                [SVProgressHUD showErrorWithStatus:@"请正确填写手机号码"];
                return;
            }
            
        }
        SharedData *sharedData = [SharedData sharedInstance];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"支付密码" message:@"支付密码为登陆密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        if ([sharedData.fingerIsOpened isEqualToString:@"yes"]) {
            [SharedAction fingerPayWithDone:^(BOOL success,id object){
                if (success) {
//                    [self payWithPassword:sharedData.payPassword];
                }else{
                    [alertView show];
                }
            }];
        }else{
            [alertView show];
        }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *lifeHall_id=[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
    NSString *passwd = [MyMD5 md5:[[alertView textFieldAtIndex:0] text]];
    NSString *payMode;
    NSString *receive_type;
    if (type1==1) {
        payMode = @"1";
    }else{
        payMode=@"2";
    }
    if (type==0) {
        receive_type=@"1";
    }else{
        receive_type=@"2";
    }
    [checkService sellerOrderWithGoodsType:@"1" andGoodsId:self.models.goods_id andGoodsNums:self.numbs andLifehall_id:lifeHall_id andPay_mode:payMode andPaypassword:passwd andReceive_type:receive_type andMessage:self.message.text andAddress:self.address.text andMobole:self.phone.text andSend_time:self.send_time.titleLabel.text andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(Status *model){
        NSLog(@"dddd");
    
    }];

}
#pragma SelectedChildViewControllerDelegate
-(void)tableView:(UITableView *)tableView didSelectedCell:(UITableViewCell *)tableViewCell withController:(UIViewController *)viewController{
    [self.send_time setTitle:tableViewCell.textLabel.text forState:UIControlStateNormal];
    [self hideChildController:viewController withObject:(id)self.send_time];
    
}
- (IBAction)sendTime:(id)sender {
     [self showTimePickerViewOnView:self.backScrollView withFrame:CGRectMake(self.senderView.frame.origin.x+self.send_time.frame.origin.x, self.senderView.frame.origin.y, self.send_time.frame.size.width,0) andDatas:self.timeArray onTarget:self withObject:(id)sender];
}
//显示pickerview
-(void)showTimePickerViewOnView:(UIView *)superView withFrame:(CGRect)frame andDatas:(NSArray *)datas onTarget:(id<SelectedItemsTableViewControllerDelegate>)delegate withObject:(id)sender{
    CheckedViewController *selfController = (CheckedViewController *)delegate;
    UIButton *button = (UIButton *)sender;
    SelectItemsTableViewController *viewController = [[SelectItemsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    viewController.view.frame = frame;
    viewController.datas =(NSMutableArray *)datas;
    viewController.delegate = selfController;
    [selfController addChildViewController:viewController];
    [superView addSubview:viewController.view];
    button.enabled = NO;
    float height = 44*datas.count;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = viewController.view.frame;
        if (frame.size.height<height) {
            frame = CGRectMake(frame.origin.x, frame.origin.y-height, frame.size.width, frame.size.height+height);
            viewController.view.frame = frame;
        }
    }];
}
//隐藏pickerview
-(void)hideChildController:(UIViewController *)childController withObject:(id)object{
    SelectItemsTableViewController *viewController = (SelectItemsTableViewController *)childController;
    NSInteger count = viewController.datas.count;
    float height = (-44*count);
    UIButton *button = (UIButton *)object;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = childController.view.frame;
        frame = CGRectMake(frame.origin.x, frame.origin.y-height, frame.size.width, frame.size.height+height);
        childController.view.frame = frame;
    } completion:^(BOOL finished){
        [childController removeFromParentViewController];
        button.enabled = YES;
    }];
}
@end
