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
@interface KillDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSTimer *timer;
    NSInteger countDownSeconds;
    GroupService *groupService;
    KillService *killService;
    WebViewController *target;
    UserInfo *user;
    SellerService *sellerService;
    KillDetailCell0 *countDownCell;
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
    checkService= [CheckService new];
    sellerService=[SellerService new];
    self.title = self.good.goods_name;
    groupService = [[GroupService alloc] init];
    killService = [[KillService alloc] init];
    killService.delegate = self;
    [sellerService sellerCountDownWithGoodsType:@"4" andGoodId:self.good.goods_id inTabBarController:self.tabBarController withDone:^(GoodsCount_Info *model){
        countDownCell.starttime =[model.start_second integerValue];
        countDownSeconds=[model.start_second integerValue];
        [self.tableView reloadData];
    }];
  
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
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        countDownCell=cell;
        return cell;
    }else if(indexPath.section==4){
        PointIndex2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointIndex2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.title.text=@"领取方式:";
            cell.detail.text=self.good.receive_from;
        }else{
            cell.title.text=@"领取地址:";
            cell.detail.text=self.good.receive_address;
        }
        return cell;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        ShowViewController *showVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowViewController"];
        showVic.seller_id=self.good.seller_id;
        [sellerService sellerInfoWithAgentid:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andSeller_type:@"" andSellerid:self.good.seller_id inRootTabBarController:self.tabBarController withDone:^(Public_Seller_info_model_info *model){
            showVic.models=model.arr_seller[0];
            [self.navigationController pushViewController:showVic animated:YES];
        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    if (alertView.tag==1) {
        if (buttonIndex==0) {
        }else if(buttonIndex==1) {
            [SharedAction shareWithTitle:self.good.goods_name andDesinationUrl:AppDownLoadURL Text:alertView.message andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.good.bigpicture] InViewController:self];
        }
    }
    if (buttonIndex==0) {
        
    }else if(buttonIndex==1) {
        [SharedAction shareWithTitle:self.good.goods_name andDesinationUrl:AppDownLoadURL Text:alertView.message andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.good.bigpicture] InViewController:self];
    }
}


- (IBAction)buyNow:(id)sender {
    if (countDownSeconds == -1) {
        [SVProgressHUD showErrorWithStatus:@"商品已过期"];
    }else if (countDownSeconds==0) {
    NSString *lifeHall_id=[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
    [checkService sellerOrderWithGoodsType:@"4" andGoodsId:self.good.goods_id andGoodsNums:@"1" andLifehall_id:lifeHall_id andPay_mode:@"" andPaypassword:@"" andReceive_type:@"" andMessage:@"" andAddress:@"" andMobole:@"" andSend_time:@"" andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(id model){
        if ([model[@"status"] isEqualToNumber: @2]) {
                    NSString *message =[NSString stringWithFormat:@"恭喜你在E小区免费抢到%@赶快去告诉朋友吧",self.good.goods_name];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"秒杀信息" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去告诉朋友", nil];
                    alertView.tag=1;
                    [alertView show];
                    self.killeNOw.backgroundColor = [UIColor grayColor];
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
