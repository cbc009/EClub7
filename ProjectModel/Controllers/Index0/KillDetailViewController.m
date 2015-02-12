//
//  KillDetailViewController.m
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "KillDetailViewController.h"
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
@interface KillDetailViewController ()<UITableViewDataSource,UITableViewDelegate,KillServiceDelegate>
{
    NSTimer *timer;
    NSInteger countDownSeconds;
    GroupService *groupService;
    KillService *killService;
    WebViewController *target;
    UserInfo *user;

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
    self.title = self.good.name;
    groupService = [[GroupService alloc] init];
    killService = [[KillService alloc] init];
    killService.delegate = self;
    self.tableview.scrollEnabled =YES;
    [killService kill_CountDownWithToken:user.token andUser_type:user.user_type andGid:self.good.gid intabBarController:self.tabBarController withObject:^(Kill_CountDown_Info *model){
        [self startCountDownActionWithSeconds:model.seconds];
        [self.tableview reloadData];
    }];
    [killService kill_Second_MemberWithToken:user.token andUser_type:user.user_type andGid:self.good.gid inTabBarController:self.tabBarController withDone:^(KillSuccess_Info *model){
       
        self.datas =(NSArray *)model.member;
        [self.tableview reloadData];
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
    return 3;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return self.datas.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        KillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KillDetailCell" forIndexPath:indexPath];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.good.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.price.text = [NSString stringWithFormat:@"%@元/%@",self.good.price,self.good.unit];
        cell.discount.text = [NSString stringWithFormat:@"%@元/%@",self.good.discount,self.good.unit];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==1){
        KillPromptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KillPromptCell"forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==2){
        NSInteger row = indexPath.row;
        KillSercessViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KillSercessViewCell"forIndexPath:indexPath];
        Success_Member_info *model = self.datas[row];
        cell.nickname.text  = model.nickname;
        [cell.herad sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.herad.layer.masksToBounds = YES;
        cell.herad.layer.cornerRadius = 30;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
          return 400;
    }else if (indexPath.section==2){
        return 80;
    }else
    {
        return 34;
    }
}
#pragma KillServiceDelegate
-(void)startCountDownActionWithSeconds:(NSInteger)seconds{
//    initTime = seconds;
    countDownSeconds = seconds;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
}


- (IBAction)buyAction:(id)sender {
    if (countDownSeconds == -1) {
        [SVProgressHUD showErrorWithStatus:@"商品已过期"];
    }else if (countDownSeconds==0) {
    [killService kill_CountDownWithToken:user.token andUser_type:user.user_type andGid:self.good.gid intabBarController:self.tabBarController withObject:^(Status *model){
        NSString *message =[NSString stringWithFormat:@"恭喜你在E小区免费抢到%@赶快去告诉朋友吧",self.good.name];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"秒杀信息" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去告诉朋友", nil];
        alertView.tag=1;
        [alertView show];
        self.buyButton.backgroundColor = [UIColor grayColor];
        //存储到Bmob后台
        BmobObject *object = [BmobObject objectWithClassName:@"KillOrder"];
        [object setObject:user.loginname forKey:@"loginname"];
        [object setObject:self.good.name forKey:@"goodName"];
        [object setObject:self.good.gid forKey:@"goodId"];
        [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        }];
    }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"还没到时间,请耐心等候"];
    }
}

-(void)countDownTimer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    KillDetailCell *cell = (KillDetailCell *)[self.tableview cellForRowAtIndexPath:indexPath];
    if (countDownSeconds==-1) {
        self.buyButton.hidden=YES;
        cell.result.text = [NSString stringWithFormat:@"秒光了瞬间秒杀%@ %@",self.good.actual_num,self.good.unit];
        [self.buyButton setBackgroundColor:[UIColor grayColor]];
        [timer invalidate];
    }else if (countDownSeconds==0) {
        [self.buyButton setBackgroundColor:[UIColor redColor]];
        [timer invalidate];
    }else{
        countDownSeconds--;
        cell.result.text = [NSString stringWithFormat:@"距离开抢时间%@",[groupService toDetailTime:countDownSeconds]];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex==0) {
        }else if(buttonIndex==1) {
            [SharedAction shareWithTitle:self.good.name andDesinationUrl:AppDownLoadURL Text:alertView.message andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.good.bigpicture] InViewController:self];
        }
    }
    if (buttonIndex==0) {
        
    }else if(buttonIndex==1) {
        [SharedAction shareWithTitle:self.good.name andDesinationUrl:AppDownLoadURL Text:alertView.message andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.good.bigpicture] InViewController:self];
    }
}
- (IBAction)shareAction:(id)sender {
    [SharedAction shareWithTitle:self.good.name andDesinationUrl:AppDownLoadURL Text:@"E小区中有秒杀的活动哦 小伙伴赶快来" andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.good.bigpicture] InViewController:self];
}

- (IBAction)segAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex==0) {
        [target.view removeFromSuperview];
        [target removeFromParentViewController];
    }else{
        if (!target) {
            [SVProgressHUD show];
            target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
            target.urlString = [NSString stringWithFormat:Kill_Goods_Detail_URL,user.token,user.user_type,self.good.gid];
            target.view.frame = CGRectMake(0, NavigationBarFrame.size.height+StatusBarFrame.size.height, DeviceFrame.size.width, DeviceFrame.size.height-NavigationBarFrame.size.height+StatusBarFrame.size.height);
        }
        [self addChildViewController:target];
        [self.view addSubview:target.view];
        [SVProgressHUD dismiss];
    }
    
}
@end
