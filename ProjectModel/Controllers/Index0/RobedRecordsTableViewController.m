//
//  RobedRecordsTableViewController.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RobedRecordsTableViewController.h"
#import "AddMoreRobedRecordService.h"
#import "RobedRecordCell.h"

#import "NSString+MT.h"
#import "JSONModelLib.h"
#import "MJRefresh.h"
#import "InternetRequest.h"
#import "SVProgressHUD.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "Member_History.h"
#import "Index0Service.h"
@interface RobedRecordsTableViewController ()
{
    NSString *identifer;
    AddMoreRobedRecordService *addMoreRobeRecord;
    NSString *subtypeId;
    UserInfo *user;
    
}
@end

@implementation RobedRecordsTableViewController


-(void)loadView{
    [super loadView];
    identifer = @"RobedRecordCell";
    UINib *nib = [UINib nibWithNibName:@"RobedRecordCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifer];
    [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    _tableview.showsVerticalScrollIndicator =NO;
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    addMoreRobeRecord = [[AddMoreRobedRecordService alloc] init];
    _page= 1;
    self.title = @"抢购记录";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.datas.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)headerRereshing
{
    _page =1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)_page];
    [addMoreRobeRecord robuy_memberWithToken:user.token andUser_type:user.user_type andGId:self.gid andPage:pageString inTabBarController:self.tabBarController withDone:^(Rob_Record_Info *model){
        self.datas = (NSMutableArray *)model.member;
        [self.tableview reloadData];
        [self.tableview headerEndRefreshing];
    }];
}


- (void)footerRereshing
{
    _page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)_page];
    [addMoreRobeRecord robuy_memberWithToken:user.token andUser_type:user.user_type andGId:self.gid andPage:pageString inTabBarController:self.tabBarController withDone:^(Rob_Record_Info *model){
        [self.datas addObjectsFromArray:model.member];
        [self.tableview reloadData];
        [self.tableview footerEndRefreshing];
    }];

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    RobedRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    Member_Info *record = [self.datas objectAtIndex:row];
    cell.nickname.text = record.nickname;
    NSString *stamp = record.regtime;
    cell.time.text = [stamp timeType1FromStamp:stamp];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 29;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

@end
