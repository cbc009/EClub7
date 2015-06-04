//
//  ShoopDetailViewController.m
//  Club
//
//  Created by MartinLi on 15-3-25.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShoopDetailViewController.h"
#import "JSDropDownMenu.h"
#import "ShoopsDetailCell.h"
#import "ShowViewController.h"
 #import "Public_Seller_info_model.h"
#import "MJRefresh.h"
#import "RatingBar.h"
#import "SellerService.h"
#import "Public_Seller.h"
#import <UIImageView+WebCache.h>
#import "ChangeBaiduApi.h"
#import "LocationXandY.h"
#import <CoreLocation/CoreLocation.h>
@interface ShoopDetailViewController ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    NSMutableArray *_data6;//子分类id 大数组
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    
    NSArray *starNumberArray;//星星数量
    SellerService *sellerService;
    UserInfo *user;
    NSInteger page;
    NSString *longitude;//经度
    NSString *latitude;//纬度
    
    NSString *typeString;//由于用的都是同一个方法获取不同的数据 这是拼得字符串
   
     NSString *seller_types;//主分类 id
    NSString *seller_sub_type;//小分类id
    NSMutableArray *_data5;//主分类id数组
    NSArray *data10;
    NSArray *_data11;
    
    
    
}
@property (nonatomic,strong)CLLocationManager *locMgr;
@end

@implementation ShoopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商户列表";
    _currentData1Index =self.index;
    self.tableview.tableFooterView =[UIView new];
    sellerService=[SellerService new];
    
    SharedData *sharedData =[SharedData sharedInstance];
    [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
    user =sharedData.user;
    self.tableview.autoresizesSubviews=YES;
    // Do any additional setup after loading the view, typically from a nib.
    typeString =[NSString stringWithFormat:@"seller_type/%@/seller_sub_type/%@/distance/%@/longitude/%@/latitude/%@",self.seller_type,seller_sub_type,data10[0],longitude,latitude];
    
        if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
             [self locationNow];
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        typeString =[NSString stringWithFormat:@"seller_type/%@/seller_sub_type/%@/distance/%@/longitude/%@/latitude/%@",self.seller_type,seller_sub_type,data10[0],longitude,latitude];
        [self headerRereshing];
        NSLog(@"定位功能不可用，提示用户或忽略");
    }
//    [self.tableview headerBeginRefreshing];    
    
    _data1 =[NSMutableArray new];
     _data5=[NSMutableArray new];
    _data6=[NSMutableArray new];
    _data2=[NSMutableArray new];
    self.data=[NSMutableArray new];
    
    NSMutableArray *_data4;//这里就是得到数组 给下拉菜单
    for (int i=0 ;i<self.cateArray.count;i++) {
        NSMutableArray *matherArray=[NSMutableArray new];
        NSMutableArray *fatherArray =[NSMutableArray new];
        Public_Seller_arr_seller_type_info *model=self.cateArray[i];
        [_data5 addObject:model.seller_type];
        for (int j=0; j<model.sub_type.count; j++) {
          
            Public_Seller_sub_type_info *object =model.sub_type[j];
            [matherArray addObject:object.sub_type_name];
            [fatherArray addObject:object.sub_type_id];
        }
        
        [_data6 addObject:fatherArray];
        _data4=[NSMutableArray arrayWithObjects:@{@"title":model.seller_type_name,@"data":matherArray},nil];//这里是单个大类对应的小类数组
        [_data1 addObjectsFromArray:_data4];//这里是将所有的大类以及小类的数组 放到一起
    }
    Public_Seller_sub_type_info *model =self.seller_type_id_array[0];
    seller_sub_type=model.sub_type_id;
    data10=self.distanceArray;
    _data11=_data6[self.index];
    for (int k=0; k<self.distanceArray.count; k++) {
        if (k==0) {
            [_data2 addObject:@"全部"];
        }else{
            [_data2 addObject:[NSString stringWithFormat:@"%@",self.distanceArray[k]]];
        }
    }
   
    seller_types=_data5[_data5.count-1];//主分类id默认为第一个
    
    _data3 = [NSMutableArray arrayWithObjects:@"不限人数", @"单人餐", @"双人餐", @"6573~4人餐", nil];//这个数组没用到
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];
}

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 2;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0) {
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        return _currentData1Index;
    }
    if (column==1) {
        return _currentData2Index;
    }
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        if (leftOrRight==0) {
            
            return _data1.count;
        } else{
            
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    } else if (column==1){
        
        return _data2.count;
        
    } else if (column==2){
        
        return _data3.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    switch (column) {
        case 0: return [[_data1[self.index] objectForKey:@"data"] objectAtIndex:0];//显示默认菜单名字
            break;
        case 1: return _data2[0];
            break;
        case 2: return _data3[0];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column==0) {
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else if (indexPath.column==1) {
        return _data2[indexPath.row];
    } else {
        return _data3[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if(indexPath.leftOrRight==0){
            _currentData1Index = indexPath.row;
            _data11=_data6[indexPath.row];
            seller_sub_type=_data11[indexPath.row];
            self.seller_type=_data5 [indexPath.row];
            return;
        }
    } else if(indexPath.column == 1){
       typeString =[NSString stringWithFormat:@"seller_type/%@/seller_sub_type/%@/distance/%@/longitude/%@/latitude/%@",self.seller_type,seller_sub_type,data10[indexPath.row],longitude,latitude];
        
        [self headerRereshing];
        _currentData2Index = indexPath.row;
        return;
    } else{
        _currentData3Index = indexPath.row;
    }
    
    seller_sub_type=_data11[indexPath.row];
   typeString =[NSString stringWithFormat:@"seller_type/%@/seller_sub_type/%@/distance/%@/longitude/%@/latitude/%@",self.seller_type,seller_sub_type,@"0",longitude,latitude];
    [self headerRereshing];
    _currentData2Index = indexPath.row;
}

-(void)locationNow{
    self.locMgr = [[CLLocationManager alloc] init];
    self.locMgr.delegate = self;
    self.locMgr.distanceFilter=kCLDistanceFilterNone;
    self.locMgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.locMgr.distanceFilter = 1000.0f;
    [self.locMgr startUpdatingLocation];
    
}
#pragma CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager//定位
     didUpdateLocations:(NSArray *)locations{
    CLLocation *loc = [locations firstObject];
    //维度：loc.coordinate.latitude
    //经度：loc.coordinate.longitude
    NSLog(@"纬度=%f，经度=%f",loc.coordinate.latitude,loc.coordinate.longitude);
    longitude=[NSString stringWithFormat:@"%f",loc.coordinate.longitude];
    latitude=[NSString stringWithFormat:@"%f",loc.coordinate.latitude];
    [sellerService changeBaiduApiWithLongitude:loc.coordinate.longitude andLatitude:loc.coordinate.latitude withDone:^(ChangeBaiduApi *model){
        Result_info *object =model.result[0];
        typeString=[NSString stringWithFormat:@"seller_type/%@/seller_sub_type/%@/distance/%@/longitude/%f/latitude/%f",self.seller_type,seller_sub_type,data10[0],object.x,object.y];
        
        [self headerRereshing];
    }];
     [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    typeString =[NSString stringWithFormat:@"seller_type/%@/seller_sub_type/%@/distance/%@/longitude/%@/latitude/%@",self.seller_type,seller_sub_type,data10[0],longitude,latitude];
    [self headerRereshing];
    NSLog(@"定位:%@",error);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    ShoopsDetailCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ShoopsDetailCell" forIndexPath:indexPath];
    Public_Seller_info_model_arr_seller_info *model =self.data[row];
    cell.work_time.text=model.work_time;
    cell.street.text=model.street;
    cell.name.text=model.seller_name;
    cell.sellerType.text=model.sub_type_name;
    cell.seller_status.text=model.seller_status;
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.logistics.text=model.logistics;
    
    RatingBar *bar = [[RatingBar alloc] initWithFrame:CGRectMake(89, 40, 80, 20)];
    [cell addSubview:bar];
    bar.starNumber=model.total_praises;
    bar.enable=NO;
    bar.frame=CGRectMake(89, 40, 60, 20);
    cell.street.text=[NSString stringWithFormat:@"%@ %@",model.street,model.distance];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{//选择下面的一行
    NSInteger row =indexPath.row;
    Public_Seller_info_model_arr_seller_info *model =self.data[row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShowViewController *showVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowViewController"];
    showVic.seller_id=self.seller_type;
    showVic.models=model;
    [self.navigationController pushViewController:showVic animated:YES];
}
-(void)headerRereshing
{
    page =1;
    [self loadDataWithPage:page andType:0];
    [self.tableview headerEndRefreshing];
}
- (void)footerRereshing
{
    page++;
    [self loadDataWithPage:page andType:1];
    [self.tableview footerEndRefreshing];    
}
-(void)loadDataWithPage:(NSInteger)pages andType:(NSInteger )type{
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)pages];
    NSString *agent_id= [NSString stringWithFormat:@"%ld",(long)user.agent_id];
    NSString *typeString0 =[NSString stringWithFormat:@"%@/page/%@",typeString,pageString];
    [sellerService publicSellerInfoWithAgent_id:agent_id anrTypeString:typeString0 inTabBarController:self.tabBarController withDone:^(Public_Seller_info_model_info *model){
        if (type==0) {
             self.data=(NSMutableArray*)model.arr_seller;
        }else{
            [self.data addObjectsFromArray:model.arr_seller];
        }
        [self.tableview reloadData];
    }];
}
@end
