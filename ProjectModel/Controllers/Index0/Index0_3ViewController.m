//
//  Index0_3ViewController.m
//  Club
//
//  Created by Gao Huang on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index0_3ViewController.h"
#import "NewsGoodsViewController.h"
#import "ChangeAgentViewController.h"
#import "ScollViewController.h"
#import "AgentViewController.h"
#import "MorePush_history.h"
#import "BuyGoodTypeCell.h"
#import "SerchViewController.h"
#import "Index1_3Cell.h"
#import "Index1_5Cell.h"
#import "Index1_6Cell.h"
#import "Index1_7Cell.h"
#import "Index0Service.h"
#import <UIImageView+WebCache.h>
#import "Goods_type.h"
#import "SharedData.h"
#import "SharedAction.h"
#import "WebViewController.h"
#import "RobViewController.h"
#import "MainItemLayout.h"
#import "MainItemCell.h"
#import "BuyService.h"
#import "Index0_1Cell.h"
#import "Index0_2Cell.h"
#import "NoticeCell.h"
#import "LoginViewController.h"
#import "SerchViewController.h"
#import "Index0Models.h"
#import "ShowViewController.h"
#import "Public_Seller_info_model.h"
#import "SellerService.h"
#import "BuyService.h"
#import "TypeGoods.h"
#import "ItemDetailViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface Index0_3ViewController ()<LoginViewControllerDelegate,UISearchBarDelegate,TapinViewDelegate,SelectIndexDelegate,SelectedIndexDelegate,CLLocationManagerDelegate>
{
    Index0Service *index0Service;
    BuyService *buyService;
    UIView *naviBarView;
    UIImageView *changeImage;
    SellerService *sellerService;
    UserInfo *user;
     ScollViewController*scollView;
    NSString *longitude;//经度
    NSString *latitude;//纬度
    SharedData *sharedData;
    
}
@property (nonatomic,strong)CLLocationManager *locMgr;
@end

@implementation Index0_3ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     sharedData= [SharedData sharedInstance];
    user= sharedData.user;
    self.cityLabel.text=user.city_name;
    [self.navigationController.navigationBar addSubview:naviBarView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAgenTReload) name:@"AgentReload" object:nil];
    sharedData = [SharedData sharedInstance];
    user= sharedData.user;
    NSLog(@"loginname:%@",sharedData.starStatus);
    if (![sharedData.starStatus isEqualToString:@"YES"]) {
         UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        scollView =[storyBoard instantiateViewControllerWithIdentifier:@"ScollViewController"];
        sharedData.starStatus=@"YES";
        [self presentViewController:scollView animated:YES completion:nil];
    }
    buyService=[BuyService new];
    index0Service = [[Index0Service alloc] init];
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
//    [index0Service loadUserDefaultsInViewController:self witLoginStatus:sharedData.loginStatus andLongitude:@"" andLatitude:@""];
    self.title=user.lifehall_name;
     NSLog(@"%@",sharedData.loginStatus);
    [self locationNow];
    self.collectionDatas = [NSArray arrayWithObjects:@"充值",@"抽奖",@"商户",@"购物车",nil];
    self.collectionImgs = [NSArray arrayWithObjects:@"chongzhi.png",@"choujiang.png",@"qianbao.png",@"gouwuche.png", nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    [naviBarView removeFromSuperview];
    
}
-(void)locationNow{
    self.locMgr = [[CLLocationManager alloc] init];
    self.locMgr.delegate = self;
    self.locMgr.distanceFilter=kCLDistanceFilterNone;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.locMgr.distanceFilter = 1000.0f;
    //定位服务是否可用
    BOOL enable=[CLLocationManager locationServicesEnabled];
    //是否具有定位权限
    int status=[CLLocationManager authorizationStatus];
    if(!enable || status<3){
        //请求权限
        [self.locMgr requestAlwaysAuthorization];
    }
    [self.locMgr startUpdatingLocation];
}

#pragma CLLocationManagerDelegate
//定位
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *loc = [locations firstObject];
    NSLog(@"纬度=%f，经度=%f",loc.coordinate.latitude,loc.coordinate.longitude);
    longitude=[NSString stringWithFormat:@"%f",loc.coordinate.longitude];
    latitude=[NSString stringWithFormat:@"%f",loc.coordinate.latitude];
    [index0Service loadUserDefaultsInViewController:self witLoginStatus:sharedData.loginStatus andLongitude:longitude andLatitude:latitude];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"定位:%@",error);
}

-(void)setNaviView{
    naviBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceFrame.size.width, 44)];
    naviBarView.backgroundColor=[UIColor redColor];
    UIView *labelView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCity)];
    [labelView addGestureRecognizer:tap1];
    self.cityLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 24)];
    self.cityLabel.textColor=[UIColor whiteColor];
    self.cityLabel.text=@"长沙市";
    [labelView addSubview:self.cityLabel];
    [naviBarView addSubview:labelView];
  
    UIButton *seach =[UIButton buttonWithType:UIButtonTypeCustom];
    seach.frame=CGRectMake(90, 8, 180, 28);
    [seach setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [seach setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateHighlighted];
    [seach addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
//    [seach setTitle:@"搜索" forState:UIControlStateNormal];
    [naviBarView addSubview:seach];
    
    changeImage=[[UIImageView alloc]initWithFrame:CGRectMake(62, 11, 15, 15)];
    changeImage.image=[UIImage imageNamed:@"triangles"];
    [naviBarView addSubview:changeImage];
    
    UIButton *messageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame=CGRectMake(DeviceFrame.size.width-40, 10, 28, 21);
    [messageBtn addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setBackgroundImage:[UIImage imageNamed:@"icon_messageCenter_empty"] forState:UIControlStateNormal];
    [messageBtn setBackgroundImage:[UIImage imageNamed:@"icon_messageCenter_empty"] forState:UIControlStateHighlighted];
    [naviBarView addSubview:messageBtn];    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"Pushhistor"]){
        UIViewController *viewController = segue.destinationViewController;
        viewController.hidesBottomBarWhenPushed = YES;
    }
}

#pragma UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section==0) {
        Index0_1Cell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"Index0_1Cell" forIndexPath:indexPath];
        cell.pageview.imageType = UIImageUrlType;
        cell.pageview.imgUrls = [index0Service namesFromPictures:self.pageviewDatas];
        cell.pageview.titles = [index0Service titlesFromPictures:self.pageviewDatas];
        cell.pageview.urls = [index0Service urlsFromPictures:self.pageviewDatas];
        cell.pageview.martinLiPageScrollViewDelegate = self;
        cell.pageview.isAutoScroll = YES;
        cell.pageview.titleIsHidden = YES;//默认为NO（可选）
        cell.pageview.height = cell.pageHeight.constant;
        cell.pageview.pageViewType = MLPageScrollViewAdvertiseMode;//默认是广告模式（可选）
        cell.pageview.timeInterval = 4;//默认自动滚动图片时间为2秒（可选）
        [cell.pageview updatePageViewInSuperView:self.view];
        cell.pageview.defaultLocationIndex = 2;//这一步必须放在最后。（可选）
        return cell;
    }else if(section==1){
        Index0_2Cell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"Index0_2Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(section==2){
        NoticeCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"NoticeCell" forIndexPath:indexPath];
        cell.marqueeLabel.text=self.objects.push_info;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(section==3){
        Index1_3Cell * cell = [self.tableview dequeueReusableCellWithIdentifier:@"Index1_3Cell" forIndexPath:indexPath];
        Index0Models_Arr_Model_info *model=self.objects.arr_model;
        Index0Models_Arr_Model_Team_info *models1=model.robuy;
        cell.robTitle.text=models1.title;
        cell.robDetail.text=models1.sub_title;
        [cell.robGoodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,models1.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
       
        Index0Models_Arr_Model_Team_info *models2=model.team;
        cell.teamTitle.text=models2.title;
        cell.temaDetail.text=models2.sub_title;
        [cell.teamPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,models2.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        
        Index0Models_Arr_Model_Team_info *models3=model.newgoods;
        cell.dayNew.text=models3.title;
        cell.dayDetail.text=models3.sub_title;
        [cell.dayPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,models3.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        
        Index0Models_Arr_Model_Team_info *models4=model.second;
        cell.KillName.text=models4.title;
        cell.killDetail.text=models4.sub_title;
        [cell.killPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,models4.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        Index0Models_Arr_Model_Team_info *models5=model.exchange;
        cell.pointTitle.text=models5.title;
        cell.pointDetail.text=models5.sub_title;
        [cell.pointPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,models5.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.delegate=self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (section==4){
        Index1_5Cell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"Index1_5Cell" forIndexPath:indexPath];
        cell.datas =self.objects.arr_seller;
        cell.delegate=self;
        [cell.collectionView reloadData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (section==5){
        Index1_6Cell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"Index1_6Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        Index1_7Cell*cell = [self.tableview dequeueReusableCellWithIdentifier:@"Index1_7Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.datas=self.objects.arr_goods;
    
        [cell.collictionView reloadData];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    NSInteger section = indexPath.section;
    if (section==0) {
        return 110;
    }else if (section==1){
        return 65;
    }else if(section==2){
        return 30;
    }else if(section==3){
        return 230;
    }else if (section==4){
        return 163;
    }else if(section==5){
        return 40;
    }else if (section==6){
        return 480;
    }else{
        return 109;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0||section==6||section==5) {
        
        return 0;
    }else if(section==3){
        return 2;
    }else {
        return 8;
    }
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainItemCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    cell.title.text = self.collectionDatas[row];
    cell.imgView.image = [UIImage imageNamed:self.collectionImgs[row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSString *storyboardName = nil;
    NSString *identifier = nil;
    if (row==0) {
        storyboardName = @"Index3";
        identifier = @"CreatePayViewController";
    }else if (row==1){
        storyboardName = @"Index0";
        identifier = @"Index1ViewController";
    }else if(row==2){
        storyboardName = @"Index0";
        identifier = @"ShoopsViewController";
    }else {
        storyboardName = @"Index0";
        identifier = @"PurchaseCarItemsViewController";
    }
    if (storyboardName!=nil&&identifier!=nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        UIViewController *target = [storyboard instantiateViewControllerWithIdentifier:identifier];
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }else{
        NSLog(@"storyboardName为nil，或者identifier为nil");
    }
}
-(void)tapInViewWithTag:(NSInteger)tag inCell:(Index1_3Cell*)cell{
    NSString *storyboardName = nil;
    NSString *identifier = nil;
    switch (tag) {
        case 1:
            storyboardName = @"Index0";
            identifier = @"RobViewController";
            break;
        case 2:
            storyboardName = @"Index0";
            identifier = @"GroupsViewController";
            break;
        case 3:
            storyboardName = @"Index0";
            identifier = @"NewsGoodsViewController";
            break;
        case 4:
            storyboardName = @"Index0";
            identifier = @"KillListViewController";
            break;
        case 5:
            storyboardName = @"Index0";
            identifier = @"PointViewController";
            break;
            
        default:
            break;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *target = [storyboard instantiateViewControllerWithIdentifier:identifier];
    target.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:target animated:YES];
}

#pragma MartinLiPageScrollViewDelegate
-(void)imgViewDidTouchActionAtIndex:(NSInteger)index inArray:(NSArray *)array{
    NSString *url = array[index];
    if ([url  hasPrefix:@"http"]) {
        WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        target.urlString = url;
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }else{
        NSLog(@"第%ld张图片暂无url",(long)index);
    }
}

-(void)selectIndexInCell:(Index1_7Cell*)cell andGoodsId:(NSString *)goodId{
    
    [buyService goods_Goods_InfoWithGoodId:goodId nTabBarController:self.tabBarController withDone:^(Type_Goods_info *model){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        ItemDetailViewController *target = [storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];
        target.goodModel=(Type_goods_good*)model.goods;
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }];
}

-(void)selectIndexInCell:(Index1_5Cell*)cell andSellerId:(NSString *)seller_id{
    sellerService =[SellerService new];
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShowViewController *showVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowViewController"];
    showVic.seller_id=seller_id;
    [sellerService sellerInfoWithAgentid:[NSString stringWithFormat:@"%ld",(long)sharedData.user.agent_id] andSeller_type:@"" andSellerid:seller_id inRootTabBarController:self.tabBarController withDone:^(Public_Seller_info_model_info *model){
        showVic.models=model.arr_seller[0];
        showVic.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:showVic animated:YES];
    }];
}

-(void)changeCity{
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"ChangeAgent" bundle:nil];
    ChangeAgentViewController *changeAgentVIewController =[storBoard instantiateViewControllerWithIdentifier:@"ChangeAgentViewController"];
    [self presentViewController:changeAgentVIewController animated:YES completion:nil];
}

-(void)message{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    UIViewController *target = [storyboard instantiateViewControllerWithIdentifier:@"MorePush_history"];
    target.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:target animated:YES];

}
-(void)search{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    UIViewController *target = [storyboard instantiateViewControllerWithIdentifier:@"SerchViewController"];
    target.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:target animated:YES];
}
-(void)changeAgenTReload{
//    Index0Service *index0Service = [Index0Service new];
    [index0Service loadAdverPicWithPos:1 andAgentID:sharedData.user.agent_id inViewController:self];
    [index0Service loginIndexWithAgentId:sharedData.user.agent_id andLifeHallId:sharedData.user.lifehall_id inViewCOntroller:self];

}
@end
