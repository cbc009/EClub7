//
//  SellerOrderDetailViewController.m
//  Club
//
//  Created by MartinLi on 15-4-7.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "SellerOrderDetailViewController.h"
#import "ShowViewController.h"
#import <UIImageView+WebCache.h>
#import "Status.h"
#import "SellerService.h"
#import "QRCodeGenerator.h"
#import "SellerOrderCell.h"
#import "SellerOrderCell1.h"
#import "SellerOrderCell2.h"
#import "SellerOrderCell3.h"
#import "SellerOrderCell4.h"
@interface SellerOrderDetailViewController ()<SellerOderDeleGate>
{
    SellerService *sellerService;
    UserInfo *user;
}
@end

@implementation SellerOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"订单详情";
    sellerService=[SellerService new];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==3) {
        return 3;
    }else if(section==4){
        return 2;
        
    }else{
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    if (indexPath.section==0) {
        SellerOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerOrderCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.orderStatus.text =self.model.status_name;
        if ([self.model.status isEqualToString:@"1"]) {
        }else{
         cell.backGood.hidden=YES;
        }
        return cell;
    }else if (indexPath.section==1){
        SellerOrderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerOrderCell1"];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.name.text=self.model.seller_name;
        return cell;
    }else if (indexPath.section==2){
        SellerOrderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerOrderCell2"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.goodsPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.goodName.text=self.model.goods_name;
        cell.numb.text=self.model.actual_nums;
        cell.nums.text=[NSString stringWithFormat:@"%@%@",self.model.actual_nums,self.model.unit];
        if (self.model.amount_point==0) {
            cell.price.text=[NSString stringWithFormat:@"%0.2f元",self.model.amount_total];
        }else{
            cell.price.text=[NSString stringWithFormat:@"%0.0fE币",self.model.amount_total];
        }
        
        cell.amount.text=[NSString stringWithFormat:@"%0.2f",self.model.amount];
        cell.amount_red.text=[NSString stringWithFormat:@"%0.2f",self.model.amount_red];
        cell.point.text=[NSString stringWithFormat:@"%0.0f",self.model.amount_point];
        return cell;
    }else if (indexPath.section==3){
        SellerOrderCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerOrderCell3"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.orderType.text=@"订单号";
            cell.order.text=self.model.order_id;
        }else if(row==1){
            cell.orderType.text=@"订单类型";
            cell.order.text=self.model.goods_type_name;
        }else{
            cell.orderType.text=@"订单时间";
            cell.order.text=self.model.regtime;
        }
        return cell;
    }else if (indexPath.section==4){
        SellerOrderCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerOrderCell3"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.orderType.text=@"领取时间";
            cell.order.text=self.model.receive_time;
        }else{
            cell.orderType.text=@"领取地点";
            cell.order.text=self.model.receive_address;
        }
        return cell;
    }else if(indexPath.section==5){
        SellerOrderCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerOrderCell4"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.qCode.image = [QRCodeGenerator qrImageForString:self.model.receive_url imageSize:cell.qCode.frame.size.width];
        return cell;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2||section==0) {
        return 0;
    }
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 36;
    }else if (indexPath.section==1){
        return 33;
    
    }else if (indexPath.section==2){
        return 168;
        
    }else if (indexPath.section==3||indexPath.section==4){
        return 31;
        
    }else {
        return 106;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        ShowViewController *showVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowViewController"];
        
        NSString *typeString =[NSString stringWithFormat:@"seller_id/%@",self.model.seller_id];
        NSString *agent_id =[NSString stringWithFormat:@"%ld",(long)user.agent_id];
        
        [sellerService publicSellerInfoWithAgent_id:agent_id anrTypeString:typeString inTabBarController:self.tabBarController withDone:^(Public_Seller_info_model_info *model){
            showVic.seller_id=self.model.seller_id;
            showVic.models=model.arr_seller[0];
            [self.navigationController pushViewController:showVic animated:YES];
        }];
    }
   
}


-(void)backGoods:(id)sender InCell:(SellerOrderCell*)cell{
    [sellerService sellerOrderReturnwithToken:user.token andUser_type:user.user_type andOrder_id:self.model.order_id inTabBarController:self.tabBarController withDone:^(Status *model){
        if (model.status==2) {
            [SVProgressHUD showSuccessWithStatus:model.error];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];

}
@end
