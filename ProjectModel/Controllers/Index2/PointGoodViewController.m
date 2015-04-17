//
//  PointGoodViewController.m
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PointGoodViewController.h"
#import "ShowViewController.h"
#import "Public_Seller_info_model.h"
#import "SellerService.h"
#import "CheckService.h"
#import "MyMD5.h"
#import "SharedData.h"
#import "PointIndex0Cell.h"
#import "PointIndex1Cell.h"
#import "PointIndex2Cell.h"
#import "RobIndex1_Cell.h"
#import "Member_Login.h"
#import "PointGoodViewControllerService.h"
#import "Status.h"
#import <UIImageView+WebCache.h>
@interface PointGoodViewController ()<UIAlertViewDelegate>
{
    NSInteger sum;
    UserInfo *user;
    SharedData *sharedData;
    PointGoodViewControllerService *pointGoodViewControllerService;
    PointIndex1Cell *numberCell;
    CheckService *checkService;
    SellerService *sellerService;
}
@end

@implementation PointGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    checkService=[CheckService new];
    sellerService =[SellerService new];
    self.title = @"商品兑换详情";
    pointGoodViewControllerService = [[PointGoodViewControllerService alloc] init];
    
    
    self.title = self.models.goods_name;
//    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,[self.dict valueForKey:@"bigpicture"]]] placeholderImage:[UIImage imageNamed:@"e"]];
//    self.ePrize.text = [NSString stringWithFormat:@"%@/份",[self.dict valueForKey:@"point"]];;
//    self.gid = [[self.dict valueForKey:@"gid"]integerValue];
//    sum = 1;
//    self.num.text = [NSString stringWithFormat:@"%ld",(long)sum];
    sharedData = [SharedData sharedInstance];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==4) {
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      NSInteger row =indexPath.row;
    if (indexPath.section==0) {
        PointIndex0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex0Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
         [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.models.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.goodName.text=self.models.goods_name;
        cell.discount.text=[NSString stringWithFormat:@"%@E币/%@",self.models.point,self.models.unit];
        cell.nums.text=[NSString stringWithFormat:@"%@已兑换",self.models.actual_nums];
        return cell;
    }else if (indexPath.section==1){
        PointIndex2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.title.text=@"商品提供方";
        cell.detail.hidden=YES;
        return cell;

    }else if(indexPath.section==2){
        RobIndex1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"RobIndex1_Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.sellerName.text=self.models.seller_name;
        cell.sellerDetail.text =self.models.seller_intro;
        [cell.sellerPIc sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.models.seller_picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else if(indexPath.section==3){
        PointIndex1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex1Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        numberCell =cell;
        return cell;
    }else if(indexPath.section==4){
        PointIndex2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.title.text=@"领取方式:";
            cell.detail.text=self.models.receive_from;
        }else{
            cell.title.text=@"领取地址:";
           cell.detail.text=self.models.receive_address;
        }
        return cell;
    }else{
       return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1||section==3) {
        return 8;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section =indexPath.section;
  
    if (section==0) {
        return 265;
    }else if (section==1){
        return 35;
    }else if(section==2){
        return 82;
    }else if(section==3){
        return 38;
    }else if(section==4){
        return 35;
    }else{
        return 0;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        ShowViewController *showVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowViewController"];
        showVic.seller_id=self.models.seller_id;
        [sellerService sellerInfoWithAgentid:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andSeller_type:@"" andSellerid:self.models.seller_id inRootTabBarController:self.tabBarController withDone:^(Public_Seller_info_model_info *model){
            showVic.models=model.arr_seller[0];
            [self.navigationController pushViewController:showVic animated:YES];
        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     if (alertView.tag==3) {
        if(buttonIndex==1){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }else if (alertView.tag==4){
        if(buttonIndex == 1){
        NSString *password = [[alertView textFieldAtIndex:0] text];
        [self payWithPassword:password];
         }
    }else {
       if(buttonIndex == 1){
        NSString *password = [[alertView textFieldAtIndex:0] text];
        [self payWithPassword:password];
       }
    }
}


-(void)payWithPassword:(NSString *)password
{
    NSString *passwd = [MyMD5 md5:password];
    NSString *lifeHall_id=[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
    [checkService sellerOrderWithGoodsType:@"5" andGoodsId:self.models.goods_id andGoodsNums:numberCell.nums.text andLifehall_id:lifeHall_id andPay_mode:@"" andPaypassword:passwd andReceive_type:@"" andMessage:@"" andAddress:@"" andMobole:@"" andSend_time:@"" andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(id model){
        if ([model[@"status"] isEqualToNumber: @2]) {
            UIAlertView *aletview=[[UIAlertView alloc]initWithTitle:@"兑换成功" message:@"购买成功请及时到生活馆领取" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            aletview.tag=3;
            [aletview show];
        }
    }];

}

- (IBAction)buyNOw:(id)sender {
    if ([numberCell.nums.text isEqualToString:@"0"]) {
        [SVProgressHUD showErrorWithStatus:@"购买数量不能为0"];
    }else{
        NSInteger totalPoint = [numberCell.nums.text integerValue]* [self.models.point integerValue];
        NSString *message = [NSString stringWithFormat:@"您即将支付%ld积分购买%@,支付密码为手机号码后六位",(long)totalPoint,self.title];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认支付" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        if ([sharedData.fingerIsOpened isEqualToString:@"yes"]) {
            [SharedAction fingerPayWithDone:^(BOOL success,id object){
                if (success) {
                    [self payWithPassword:sharedData.payPassword];
                }else{
                    [alertView show];
                }
            }];
        }else{
            [alertView show];
        }
    }
}

- (IBAction)share:(id)sender {
    NSString *share_url=[NSString stringWithFormat:Seller_Seller_Goods_Share_URL,self.models.goods_id];
    [SharedAction shareWithTitle:self.title andDesinationUrl:share_url Text:self.models.goods_name andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.models.bigpicture] InViewController:self];

}
@end
