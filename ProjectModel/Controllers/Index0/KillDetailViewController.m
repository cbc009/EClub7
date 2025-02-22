//
//  KillDetailViewController.m
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "KillDetailViewController.h"
#import "ShowViewController.h"
#import "CheckService.h"
#import "PointIndex0Cell.h"
#import "PointIndex1Cell.h"
#import "PointIndex2Cell.h"
#import "KillIndex1_Cell.h"
#import "KillDetailCell0.h"
#import "SellerService.h"
#import "GoodsCountDownModel.h"
#import "KillDetailCell.h"
#import <UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "GroupService.h"
#import "KillService.h"
#import "SharedAction.h"
#import "KillListViewController.h"
#import "KillSercessViewCell.h"
#import "KillPromptCell.h"
#import "Kill_CountDown.h"
#import "WebViewController.h"
#import "KIllSuccess.h"
#import <UIImageView+WebCache.h>
#import "Status.h"
#import <BmobSDK/Bmob.h>
@interface KillDetailViewController ()<UITableViewDataSource,UITableViewDelegate,KillSecondCountDownDelegate>
{
    NSTimer *timer;
    GroupService *groupService;
    KillService *killService;
    UserInfo *user;
    SellerService *sellerService;
    CheckService *checkService;

}
@end

@implementation KillDetailViewController

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    if (user.user_type!=2) {
        UIAlertView *aletview=[[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"由于您还没有登录，为了抢到您心仪的宝贝建议您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定登录", nil];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        aletview.tag=5;
        [aletview show];
        return;
    }
    
    checkService= [CheckService new];
    sellerService=[SellerService new];
    self.title = self.good.goods_name;
    groupService = [[GroupService alloc] init];
    killService = [[KillService alloc] init];
//    [sellerService sellerCountDownWithGoodsType:@"4" andGoodId:self.good.goods_id inTabBarController:self.tabBarController withDone:^(GoodsCount_Info *model){
//        countDownCell.starttime =[model.start_second integerValue];
//        countDownSeconds=[model.start_second integerValue];
//        [self.tableView reloadData];
//    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==4||section==1) {
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    if (indexPath.section==0) {
        PointIndex0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex0Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.good.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.goodName.text=self.good.goods_name;
        cell.title.text=@"秒杀价:";
        cell.discount.text=[NSString stringWithFormat:@"￥%@/%@",self.good.discount,self.good.unit];
        cell.nums.text=[NSString stringWithFormat:@"原价:￥%@/%@",self.good.price,self.good.unit];
        return cell;
    }else if (indexPath.section==1){
        PointIndex2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
        cell.title.text=@"商品提供方";
        cell.detail.hidden=YES;
        if (indexPath.row==0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.title.text=@"商品详情";
        }
        return cell;
    }else if(indexPath.section==2){
        KillIndex1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"KillIndex1_Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.sellername.text=self.good.seller_name;
        [cell.sellerDetails  loadHTMLString:self.good.seller_intro baseURL:nil];
        [cell.sellerPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.good.seller_picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else if(indexPath.section==3){
        KillDetailCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"KillDetailCell0" forIndexPath:indexPath];
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.starttime=self.countDownSeconds;
        cell.endtime=self.end_seconds;
        return cell;
    }else if(indexPath.section==4){
        PointIndex2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.title.text=@"领取方式:";
            cell.detail.font=[UIFont systemFontOfSize:10];
            cell.detail.text=self.good.receive_from;
        }else{
            cell.title.text=@"领取地址:";
            cell.detail.font=[UIFont systemFontOfSize:10];
            cell.detail.text=self.good.receive_address;
        }
        return cell;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        ShowViewController *showVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowViewController"];
        showVic.seller_id=self.good.seller_id;
        [sellerService sellerInfoWithAgentid:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andSeller_type:@"" andSellerid:self.good.seller_id inRootTabBarController:self.tabBarController withDone:^(Public_Seller_info_model_info *model){
            showVic.models=model.arr_seller[0];
            [self.navigationController pushViewController:showVic animated:YES];
        }];
    }else if(indexPath.section==1){
        if (indexPath.row==0){
            WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
            target.loadType=0;
            target.urlString = [NSString stringWithFormat:Robuy_Goods_Detail_URL,self.good.goods_id];
            target.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:target animated:YES];
        }
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section =indexPath.section;
    if (section==0) {
        return 265;
    }else if (section==1){
        return 35;
    }else if(section==2){
        return 82;
    }else if(section==3){
        return 63;
    }else if(section==4){
        return 35;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1||section==3) {
        return 8;
    }else{
        return 0;
    }
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
        [SharedAction shareWithTitle:self.good.goods_name andDesinationUrl:AppDownLoadURL Text:alertView.message andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.good.bigpicture] InViewController:self];
    }
    }
}
-(void)startCountDownActionWithSeconds:(NSInteger)seconds{
    self.countDownSeconds=seconds;
    if (seconds>=0) {
        self.killeNOw.backgroundColor=[UIColor grayColor];
    }if (0>=seconds||seconds>=-4) {
        self.killeNOw.backgroundColor=[UIColor redColor];
    } else{
        self.killeNOw.backgroundColor=[UIColor grayColor];
    }
}

- (IBAction)buyNow:(id)sender {
    if (self.countDownSeconds==-5) {
        [SVProgressHUD showErrorWithStatus:@"商品已过期"];
        return;
    }else if (self.countDownSeconds<=0&self.countDownSeconds>-5) {
    NSString *lifeHall_id=[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
    [checkService sellerOrderWithGoodsType:@"4" andGoodsId:self.good.goods_id andGoodsNums:@"1" andLifehall_id:lifeHall_id andPay_mode:@"2" andPaypassword:@"" andReceive_type:@"" andMessage:@"秒杀" andAddress:@"" andMobole:user.loginname andSend_time:@"" andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(id model){
        if ([model[@"status"] isEqualToNumber: @2]) {
            self.killeNOw.backgroundColor=[UIColor grayColor];
                    NSString *message =[NSString stringWithFormat:@"恭喜你在E小区免费抢到%@赶快去告诉朋友吧",self.good.goods_name];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"秒杀信息" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去告诉朋友", nil];
                    alertView.tag=1;
                    [alertView show];
                    //存储到Bmob后台
                    BmobObject *object = [BmobObject objectWithClassName:@"KillOrder"];
                    [object setObject:user.loginname forKey:@"loginname"];
                    [object setObject:self.good.goods_name forKey:@"goodName"];
                    [object setObject:self.good.goods_id forKey:@"goodId"];
                    [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    }];
        }
    }];
    } else{
        [SVProgressHUD showErrorWithStatus:@"还没到时间,请耐心等候"];
    }
}
- (IBAction)share:(id)sender {
    [SharedAction shareWithTitle:self.good.goods_name andDesinationUrl:AppDownLoadURL Text:@"E小区中有秒杀的活动哦 小伙伴赶快来" andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.good.bigpicture] InViewController:self];

}
@end
