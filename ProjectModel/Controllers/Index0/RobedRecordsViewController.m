//
//  RobedRecordsViewController.m
//  Club
//
//  Created by MartinLi on 15-3-9.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RobedRecordsViewController.h"
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
@interface RobedRecordsViewController ()
{
    NSString *identifer;
    AddMoreRobedRecordService *addMoreRobeRecord;
    NSString *subtypeId;
    UserInfo *user;
    
}
@end

@implementation RobedRecordsViewController


-(void)loadView{
    [super loadView];
    self.title=@"抢购名单";
    identifer = @"RobedRecordCell";
    UINib *nib = [UINib nibWithNibName:@"RobedRecordCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:identifer];
    [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
    [self.tableview headerBeginRefreshing];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    _tableview.showsVerticalScrollIndicator =NO;
//    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    addMoreRobeRecord = [[AddMoreRobedRecordService alloc] init];
    _page= 1;
    self.title = @"抢购记录";
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    [self.tableview headerEndRefreshing];
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
    [addMoreRobeRecord robuy_memberWithGId:self.gid andPage:pageString inTabBarController:self.tabBarController withDone:^(Rob_Record_Info *model){
        self.datas = (NSMutableArray *)model.arr_member;
        [self.tableview reloadData];
        [self.tableview headerEndRefreshing];
    }];
}


- (void)footerRereshing
{
    _page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)_page];
    [addMoreRobeRecord robuy_memberWithGId:self.gid andPage:pageString inTabBarController:self.tabBarController withDone:^(Rob_Record_Info *model){
        [self.datas addObjectsFromArray:model.arr_member];
        [self.tableview reloadData];
        [self.tableview footerEndRefreshing];
    }];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    RobedRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    Member_Info *record = [self.datas objectAtIndex:row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.nickname.text = record.nickname;
    cell.time.text = record.regtime;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 29;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}

@end
