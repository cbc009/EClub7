//
//  RewardRecordsViewController.m
//  Club
//
//  Created by dongway on 14-8-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RewardRecordsViewController.h"
#import "RewardCell.h"
#import "MJRefresh.h"
#import "InternetRequest.h"
#import "SVProgressHUD.h"
#import "NSString+MT.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "JSONModelLib.h"
#import "RewardRcord.h"
#import "RewardRecordService.h"
@interface RewardRecordsViewController ()
{
    
    __weak IBOutlet UITableView *tableview;
    NSMutableArray *datas;
    NSString *identifier;
    NSInteger page;
    NSDictionary *dic;
    UserInfo *user;
    RewardRecordService *rewardRecordService;
}
@end

@implementation RewardRecordsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{
    [super loadView];
    identifier = @"RewardCell";
    UINib *nib = [UINib nibWithNibName:@"RewardCell" bundle:nil];
    [tableview registerNib:nib forCellReuseIdentifier:identifier];
    tableview.delegate = self;
    tableview.dataSource = self;
}

- (void)viewDidLoad
{
    datas =[[NSMutableArray alloc] init];
    SharedData *shareData = [SharedData sharedInstance];
    user = shareData.user;
    rewardRecordService =[RewardRecordService new];
    [super viewDidLoad];
    self.title = @"中奖记录";
    [SharedAction setupRefreshWithTableView:tableview toTarget:self];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    [tableview headerEndRefreshing];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    page = 1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [rewardRecordService prizePrizeLuckyWithToken:user.token andUser_type:user.user_type andPageString:pageString andTabBarController:self.tabBarController witDone:^(RewardRcordInfo *model){
        datas= (NSMutableArray *)model.lucky;
        [tableview reloadData];
        [tableview headerEndRefreshing];
    }];
}

- (void)footerRereshing
{
    page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [rewardRecordService prizePrizeLuckyWithToken:user.token andUser_type:user.user_type andPageString:pageString andTabBarController:self.tabBarController witDone:^(RewardRcordInfo *model){
        [datas addObjectsFromArray:model.lucky];
        [tableview reloadData];
        [tableview footerEndRefreshing];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.section;
    LuckyInfo *data = datas[row];
    RewardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
   
    // Configure the cell...
    cell.rewardValue.text = data.cash;
    cell.time.text = data.regtime;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}


@end
