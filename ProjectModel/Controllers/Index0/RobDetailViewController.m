//
//  RobDetailViewController.m
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RobDetailViewController.h"
#import "Public_Seller_info_model.h"
#import "CheckService.h"
#import "SellerService.h"
#import "SellerService.h"
#import "ShowViewController.h"
#import "RobIndex1_Cell.h"
#import "Index0_Cell.h"
#import "WebCell.h"
#import "RobTitleCell.h"
#import "RobedRecordsViewController.h"
#import "NSString+MT.h"
#import <UIImageView+WebCache.h>
#import "SellerDetailViewController.h"
#import "WebViewController.h"
#import "GoodsCountDownModel.h"
#import "RobService.h"
#import "Status.h"
#import <BmobSDK/Bmob.h>
@interface RobDetailViewController ()<UIWebViewDelegate>
{
    RobService *robService;
    NSString *sharurl;
//    NSInteger countDownSeconds;
    CheckService *checkService;
    SellerService *sellerService;
    RobTitleCell *countDownCell;
}
@end

@implementation RobDetailViewController
{
    UserInfo *user;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.title=@"抢购详情";
    if (user.user_type!=2) {
        UIAlertView *aletview=[[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"由于您还没有登录，为了抢到您心仪的宝贝建议您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定登录", nil];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        aletview.tag=5;
        [aletview show];
    }
    robService =[RobService new];
    checkService =[CheckService new];
    sellerService =[SellerService new];
   
    sharurl = [NSString stringWithFormat:Robuy_Share_URL,self.robGoodsMOdel.goods_id];
    self.tableView.autoresizesSubviews=NO;
    self.tableView.showsVerticalScrollIndicator =NO;
    self.tableView.tableFooterView =[UIView new];
    [sellerService sellerCountDownWithGoodsType:@"3" andGoodId:self.robGoodsMOdel.goods_id inTabBarController:self.tabBarController withDone:^(GoodsCount_Info *model){
        countDownCell.starttime=[model.start_second integerValue];
        countDownCell.endtime=[model.end_second integerValue];
        [self.tableView reloadData];
    }];
    self.robNowButton.layer.cornerRadius=5;
}
- (void)loadWebPageWithString:(NSString*)urlString inWebView:(UIWebView *)webView{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0){
        return 1;
    }else if (section==1){
        return 1;
    }else if(section==2){
        return 1;
    }else if(section==3){
        return 1;
    }else if(section==4){
        return 2;
    }else if(section==5){
        return 2;
    }else if(section==6){
        return 2;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSInteger section =indexPath.section;
     NSInteger row =indexPath.row;
    if (section==0) {
        RobTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RobTitleCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.goodName.text=self.robGoodsMOdel.goods_name;
        cell.saleNum.text=[NSString stringWithFormat:@"已抢%@",self.robGoodsMOdel.actual_nums];
        if ([self.robGoodsMOdel.discount isEqualToString:@"0.00"]) {
            cell.price.text=[NSString stringWithFormat:@"%@E币",self.robGoodsMOdel.point];
        }else{
            cell.price.text=[NSString stringWithFormat:@"￥:%@",self.robGoodsMOdel.discount];
        }
        cell.goodNum.text =[NSString stringWithFormat:@"抢购数量:%@",self.robGoodsMOdel.provider_nums];
        countDownCell=cell;
        cell.marketPrice.text=[NSString stringWithFormat:@"￥:%@",self.robGoodsMOdel.price];
        [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.robGoodsMOdel.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
        [cell.goodNum.layer setBorderWidth:1];   //边框宽度
        [cell.goodNum.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
        return cell;
    }else if(section==1){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.title.textColor=[UIColor blackColor];
        cell.title.text=@"查看图文详情";
        cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if(section==2){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.title.textColor=[UIColor blackColor];
        cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
        cell.title.text=@"抢购商品提供方";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(section==3){
        RobIndex1_Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"RobIndex1_Cell" forIndexPath:indexPath];
        cell.sellerName.text=self.robGoodsMOdel.seller_name;
        [cell.sellerDetails  loadHTMLString:self.robGoodsMOdel.seller_intro baseURL:nil];
        [cell.sellerPIc sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.robGoodsMOdel.seller_picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else if (section==4){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        
        cell.accessoryType=UITableViewCellAccessoryNone;
        if (row==0) {
            cell.title.textColor=[UIColor blackColor];
            cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
            cell.title.text=@"抢购时间";
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }else{
        cell.title.font=[UIFont systemFontOfSize:12];
        cell.title.textColor=[UIColor grayColor];
        cell.title.text=self.robGoodsMOdel.start_time;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else if(section==5){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
        if (row==0) {
            cell.title.textColor=[UIColor blackColor];
            cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
            cell.title.text=@"领取方式";
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }else if(row==1){
            cell.title.font=[UIFont systemFontOfSize:12];
            cell.title.text=self.robGoodsMOdel.receive_from;
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.title.textColor=[UIColor grayColor];
        }
        return cell;
    }else if(section==6){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
        if (row==0) {
            cell.title.textColor=[UIColor blackColor];
            cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
            cell.title.text=@"领取地址";
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }else{
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.title.textColor=[UIColor grayColor];
            cell.title.font=[UIFont systemFontOfSize:12];
            cell.title.text =self.robGoodsMOdel.receive_address;
        }
        return cell;
//    }else if(section==7){
//        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
//        cell.title.textColor=[UIColor blackColor];
//        cell.title.text=@"查看抢购名单";
//        cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//        return cell;
    }else{

        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    NSInteger section = indexPath.section;
    if (section==0) {
        return 308;
    }else if (section==3){
        return 82;
    }else if (section==7) {
        return 40;
    }else{
        return 34;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==3||section==0||section==1) {
        return 0;
    }else{
       return 8;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==3) {
        UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        ShowViewController *showVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowViewController"];
        showVic.seller_id=self.robGoodsMOdel.seller_id;
        [sellerService sellerInfoWithAgentid:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andSeller_type:@"" andSellerid:self.robGoodsMOdel.seller_id inRootTabBarController:self.tabBarController withDone:^(Public_Seller_info_model_info *model){
            showVic.models=model.arr_seller[0];
            [self.navigationController pushViewController:showVic animated:YES];
        }];
    }else if (indexPath.section==1) {
        WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        target.urlString = [NSString stringWithFormat:Robuy_Goods_Detail_URL,self.robGoodsMOdel.goods_id];
        target.title = @"图文简介";
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)robNow:(id)sender {
    NSString *lifehall_id =[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
        [checkService sellerOrderWithGoodsType:@"3" andGoodsId:self.robGoodsMOdel.goods_id andGoodsNums:@"1" andLifehall_id:lifehall_id andPay_mode:@"2" andPaypassword:@"" andReceive_type:@"" andMessage:@"抢购" andAddress:@"" andMobole:user.loginname andSend_time:@"" andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(id model){
            if ([model[@"status"] isEqualToNumber: @2]) {
                NSString *message =[NSString stringWithFormat:@"恭喜你在E小区免费抢到%@赶快去告诉朋友吧",self.robGoodsMOdel.goods_name];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抢菜信息" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去告诉朋友", nil];
                alertView.tag=1;
                [alertView show];
                self.robNowButton.backgroundColor = [UIColor grayColor];
                //存储到Bmob后台
                    BmobObject *object = [BmobObject objectWithClassName:@"RobOrder"];
                    [object setObject:user.loginname forKey:@"loginname"];
                    [object setObject:self.robGoodsMOdel.goods_name forKey:@"goodName"];
                    [object setObject:self.robGoodsMOdel.goods_id forKey:@"goodId"];
                    [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    //进行操作
                }];
            }
        }];

}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
 if(alertView.tag==5){
    if(buttonIndex==1){
        [self.tabBarController.selectedViewController beginAppearanceTransition: YES animated:YES];
        self.tabBarController.selectedIndex=0;
        UINavigationController *nav = self.tabBarController.viewControllers[self.tabBarController.selectedIndex];
        [nav popToRootViewControllerAnimated:YES];
        [SharedAction presentLoginViewControllerInViewController:nav];
    }
    }else{
    if(buttonIndex==1) {
        [SharedAction shareWithTitle:self.robGoodsMOdel.goods_name andDesinationUrl:sharurl Text:self.robGoodsMOdel.goods_name andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.robGoodsMOdel.bigpicture] InViewController:self];
        }
    }
}
- (IBAction)share:(id)sender {
   
   [SharedAction shareWithTitle:self.robGoodsMOdel.goods_name andDesinationUrl:sharurl Text:self.robGoodsMOdel.goods_name andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.robGoodsMOdel.bigpicture] InViewController:self];
}
@end
