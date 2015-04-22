//
//  PeopleDetailViewController.m
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PeopleDetailViewController.h"
#import "BackGroundCell.h"
#import "PeopleDetailCell.h"
#import "PeopleDetailService.h"
#import "LiveModel.h"
#import <UIImageView+WebCache.h>
#import "NSString+MT.h"
#import "MLMutiImagesChoosenViewController.h"
#import "MJRefresh.h"
#import "SomeoneContentViewController.h"
@interface PeopleDetailViewController ()<PeopleDetailDelegate>
{
    UserInfo *user;
    LiveModelInfo *object;
    MLMutiImagesChoosenViewController *mutiImagesContoller;
    PeopleDetailService *peopleDetailService ;
    NSInteger page;
}

@end

@implementation PeopleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SharedAction setupRefreshWithTableView:self.tableView toTarget:self];
    [self.tableView headerBeginRefreshing];
    self.automaticallyAdjustsScrollViewInsets =NO;
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.cellHeightArray = [[NSMutableArray alloc] init];
     self.labelHeightArrar = [[NSMutableArray alloc] init];
    peopleDetailService = [[PeopleDetailService alloc] init];
    self.title = self.model.nickname;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return  1;
    }else{
        return self.datas.count;
        
    }
}
-(NSArray *)imgUrlsFromTopic:(DataInfo *)object1{
    NSString *urlString;
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (int i=0; i<object1.picture.count; i++) {
        Picture_Info *info=object1.picture[i];
        urlString = [NSString stringWithFormat:@"%@%@",IP,info.picture];
        [array addObject:urlString];
    }
    return array;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        BackGroundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackGroundCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
       [cell.herad sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object.headpic]] placeholderImage:[UIImage imageNamed:@"userIcon.jpg"]];
        cell.herad.layer.masksToBounds = YES;
        cell.herad.layer.cornerRadius = 30;
        [cell.back sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object.life_picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else{
        static NSString *CellIdentifier =@"PeopleDetailCell";
        PeopleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.delegate=self;
        if (cell==nil) {
            cell = [[PeopleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        DataInfo *model = self.datas[indexPath.row];
        cell.message.text = model.content;
        UITapGestureRecognizer *goSomeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoSomeoneDetail:)];
        [cell.message addGestureRecognizer: goSomeTap];
        cell.time.text=model.regtime;
        cell.lableHeight.constant = [NSString heightWithString:model.content font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-(85-8), 600)];
        if (model.picture.count>0) {
            cell.collectoonHeight.constant=64;
        }else{
            cell.collectoonHeight.constant=0;
        }
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MLMutiImagesViewController" bundle:nil];
        mutiImagesContoller = [storyboard instantiateViewControllerWithIdentifier:@"MLMutiImagesChoosenViewController"];
        mutiImagesContoller.fatherController = self;
        mutiImagesContoller.imageMode = browseImagesMode;//（必选）
        mutiImagesContoller.imageUrls = [self imgUrlsFromTopic:model];
        mutiImagesContoller.superView = cell.collectionView;
        mutiImagesContoller.collectionviewHeight = cell.collectoonHeight.constant;
        [self addChildViewController:mutiImagesContoller];
        [cell.collectionView addSubview: mutiImagesContoller.collectionView];
        return cell;
    }
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    page = 1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [SVProgressHUD show];
    [peopleDetailService lifecircleMyinfoWithMid:[self.model.mid integerValue] andToken:user.token andUser_type:user.user_type andPageString:pageString withTabBarController:self.tabBarController witDoneObject:^(LiveModelInfo *model1){
        object =model1;
        self.datas=(NSMutableArray *)model1.data;
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    }];
}

- (void)footerRereshing
{
    page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [peopleDetailService lifecircleMyinfoWithMid:[self.model.mid integerValue] andToken:user.token andUser_type:user.user_type andPageString:pageString withTabBarController:self.tabBarController witDoneObject:^(LiveModelInfo *model1){
        object =model1;
        [self.datas addObjectsFromArray:model1.data];
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 156;
    }else{
        CGFloat topic_height = 0.0;
        CGFloat pictureHeight =0.0;
        DataInfo *dataInfo = self.datas[indexPath.row];
        topic_height = [NSString heightWithString:dataInfo.content font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(DeviceFrame.size.width-(85-8), 600)]+24;
        if (dataInfo.picture.count>0) {
            pictureHeight =64+8;
        }else{
            pictureHeight =0;
        }
        return topic_height+pictureHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        DataInfo *objects = self.datas[indexPath.row];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
        SomeoneContentViewController *someoneContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"SomeoneContentViewController"];
        someoneContentViewController.hidesBottomBarWhenPushed = YES;
        someoneContentViewController.model=objects;
        [self.navigationController pushViewController:someoneContentViewController animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==5) {
        if(buttonIndex==1){
            [SharedAction loginAggane];
            NSArray *viewControllers = self.navigationController.viewControllers;
            [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
        }
    }
}
-(void)gotoSomeoneDetail:(PeopleDetailCell*)cell
{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    DataInfo *objects = self.datas[indexpath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
    SomeoneContentViewController *someoneContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"SomeoneContentViewController"];
    someoneContentViewController.hidesBottomBarWhenPushed = YES;
    someoneContentViewController.model=objects;
    [self.navigationController pushViewController:someoneContentViewController animated:YES];
}
-(void)requestInCell:(PeopleDetailCell *)cell
{
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
