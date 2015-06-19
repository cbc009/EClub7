//
//  GroupDetailViewController.m
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "GroupDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "CheckService.h"
#import "PointIndex0Cell.h"
#import "PointIndex1Cell.h"
#import "PointIndex2Cell.h"
#import "RobIndex1_Cell.h"
#import "ShowViewController.h"
#import "Public_Seller_info_model.h"
#import "SellerService.h"
#import "GroupDetailCell.h"
#import "MyMD5.h"
#import "WebViewController.h"
#import "GroupService.h"
#import "ItemDetailService.h"
#import "SharedAction.h"
#import "SVProgressHUD.h"
#import "WebViewController.h"
#import "GroupDetallCell.h"
#import "WebViewCell.h"
#import "Status.h"
#import <BmobSdk/Bmob.h>
#import "GoodsCountDownModel.h"
@interface GroupDetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    GroupService *groupService;
    ItemDetailService *itemDetailService;
    NSTimer *timer;
    NSString *gid;
    NSString *htmlStr;
    CGFloat height1;
    UserInfo  *user;
    SellerService *sellerService;
    PointIndex1Cell *numberCell;
    SharedData *sharedData;
    CheckService *checkService;
}
@property (weak, nonatomic) IBOutlet UIButton *addGroupButton;
@end

@implementation GroupDetailViewController

-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.groupGood.goods_name;
    checkService=[CheckService new];
    sellerService =[SellerService new];
    sharedData= [SharedData sharedInstance];
    user = sharedData.user;
    
}

- (void)loadWebPageWithString:(NSString*)urlString inWebView:(UIWebView *)webView{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
}
- (IBAction)shareAction:(id)sender {
    [SharedAction shareWithTitle:self.groupGood.goods_name andDesinationUrl:AppDownLoadURL Text:@"在E小区中团购了我喜欢的宝贝好开心" andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.groupGood.bigpicture] InViewController:self];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==5||section==1) {
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    if (indexPath.section==0) {
        PointIndex0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex0Cell" forIndexPath:indexPath];
        [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.groupGood.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.goodName.text=self.groupGood.goods_name;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.title.text=@"团购价:";
        cell.discount.text=[NSString stringWithFormat:@"￥%@/%@",self.groupGood.discount,self.groupGood.unit];
        cell.price.text=[NSString stringWithFormat:@"原价:￥%@/%@",self.groupGood.price,self.groupGood.unit];
        cell.nums.text=[NSString stringWithFormat:@"%@已参团",self.groupGood.actual_nums];
        return cell;
    }else if (indexPath.section==1){
        PointIndex2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
        cell.detail.hidden=YES;
        if (row==1) {
            cell.title.text=@"商品提供方";
        }else{
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.title.text=@"图文详情";
        }
        return cell;
    }else if(indexPath.section==2){
        RobIndex1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"RobIndex1_Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.sellerName.text=self.groupGood.seller_name;
       [cell.sellerDetails  loadHTMLString:self.groupGood.seller_intro baseURL:nil];;
        [cell.sellerPIc sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.groupGood.seller_picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else if(indexPath.section==3){
        GroupDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupDetailCell" forIndexPath:indexPath];
        cell.end_seconds=self.end_seconds;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section==4){
        PointIndex1Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"PointIndex1Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        numberCell=cell;
        return cell;
    }else if(indexPath.section==5){
        PointIndex2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.title.text=@"领取方式:";
            cell.detail.text=self.groupGood.receive_from;
        }else{
            cell.title.text=@"领取地址:";
            cell.detail.text=self.groupGood.receive_address;
        }
        return cell;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
       if (indexPath.row==0){
        WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        target.loadType=0;
        target.urlString = [NSString stringWithFormat:Robuy_Goods_Detail_URL,self.groupGood.goods_id];
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
       }
    }else if (indexPath.section==2) {
        UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        ShowViewController *showVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowViewController"];
        showVic.seller_id=self.groupGood.seller_id;
        [sellerService sellerInfoWithAgentid:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andSeller_type:@"" andSellerid:self.groupGood.seller_id inRootTabBarController:self.tabBarController withDone:^(Public_Seller_info_model_info *model){
            showVic.models=model.arr_seller[0];
            [self.navigationController pushViewController:showVic animated:YES];
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section =indexPath.section;
    if (section==0) {
        return 285;
    }else if (section==1){
        return 35;
    }else if(section==2){
        return 82;
    }else if(section==3){
        return 38;
    }else if(section==4){
        return 38;
    }else{
        return 35;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1||section==3) {
        return 8;
    }else{
        return 0;
    }
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
    }else if(alertView.tag==5){
        if(buttonIndex==1){
            [self.tabBarController.selectedViewController beginAppearanceTransition: YES animated:YES];
            self.tabBarController.selectedIndex=0;
            UINavigationController *nav = self.tabBarController.viewControllers[self.tabBarController.selectedIndex];
            [nav popToRootViewControllerAnimated:YES];
            [SharedAction presentLoginViewControllerInViewController:nav];
        }
    }else{
        if(buttonIndex == 1){
            NSString *password = [[alertView textFieldAtIndex:0] text];
            [self payWithPassword:password];
        }
    }
}
- (IBAction)buyNow:(id)sender {
    if (user.user_type!=2) {
        UIAlertView *aletview=[[UIAlertView alloc]initWithTitle:@"未登录" message:@"由于您没有登录请登录后再使用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        aletview.tag=5;
        [aletview show];
        return;
    }
    if ([numberCell.nums.text isEqualToString:@"0"]||numberCell==nil) {
        [SVProgressHUD showErrorWithStatus:@"请确认购买数量"];
    }else{
        NSInteger totalPoint = [numberCell.nums.text integerValue]* [self.groupGood.discount integerValue];
        NSString *message = [NSString stringWithFormat:@"您即将支付%ld元购买%@,支付密码为手机号码后六位",(long)totalPoint,self.title];
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
-(void)payWithPassword:(NSString *)password
{
    NSString *passwd = [MyMD5 md5:password];
    NSString *lifeHall_id=[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
    [checkService sellerOrderWithGoodsType:@"2" andGoodsId:self.groupGood.goods_id andGoodsNums:numberCell.nums.text andLifehall_id:lifeHall_id andPay_mode:@"2" andPaypassword:passwd andReceive_type:@"" andMessage:@"团购" andAddress:@"" andMobole:user.loginname andSend_time:@"" andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(id model){
        if ([model[@"status"] isEqualToNumber: @2]) {
            UIAlertView *aletview=[[UIAlertView alloc]initWithTitle:@"下单成功" message:@"购买成功请及时到生活馆领取" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            aletview.tag=3;
            [aletview show];
        }
    }];
}
@end
