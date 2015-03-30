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
#import <CoreLocation/CoreLocation.h>
@interface ShoopDetailViewController ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
        
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    
    NSArray *starNumberArray;
    SellerService *sellerService;
    UserInfo *user;
    NSInteger page;
   
    NSString *typeString;
  
    NSMutableArray *_data5;
    NSMutableArray *_data6;
    
    
    
}
@property (nonatomic,strong)CLLocationManager *locMgr;
@end

@implementation ShoopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.tableview.autoresizesSubviews=YES;
    // Do any additional setup after loading the view, typically from a nib.
    [self locationNow];
    _data1 =[NSMutableArray new];
     _data5=[NSMutableArray new];
   _data6=[NSMutableArray new];
    typeString =[NSString stringWithFormat:@"seller_type/%@",self.seller_type];
        
     [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
    NSMutableArray *_data4;
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
        _data4=[NSMutableArray arrayWithObjects:@{@"title":model.seller_type_name,@"data":matherArray},nil];
        [_data1 addObjectsFromArray:_data4];
        [_data6 addObject:fatherArray];
    }
   
    NSLog(@"%@",_data6);
    
    _data2 = [NSMutableArray arrayWithObjects:@"附近", @"1000m", @"2000m", @"3000m", @"4000m", @"5000m", @"6000m", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"不限人数", @"单人餐", @"双人餐", @"6573~4人餐", nil];
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
    sellerService=[SellerService new];
    SharedData *sharedData =[SharedData sharedInstance];
    user =sharedData.user;
    
    
    
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
        case 0: return [[_data1[0] objectForKey:@"data"] objectAtIndex:0];
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
            NSLog(@"1:%ld",(long)indexPath.row);
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else if (indexPath.column==1) {
        return _data2[indexPath.row];
        NSLog(@"2:%ld",(long)indexPath.row);
    } else {
        return _data3[indexPath.row];
        NSLog(@"3:%ld",(long)indexPath.row);
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.column == 0) {
        if(indexPath.leftOrRight==0){
            _currentData1Index = indexPath.row;
            return;
        }
    } else if(indexPath.column == 1){
        _currentData2Index = indexPath.row;
    } else{
        _currentData3Index = indexPath.row;
    }
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

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    CLLocation *loc = [locations firstObject];
    //维度：loc.coordinate.latitude
    //经度：loc.coordinate.longitude
    NSLog(@"纬度=%f，经度=%f",loc.coordinate.latitude,loc.coordinate.longitude);
    typeString =[NSString stringWithFormat:@"seller_type/%@/longitude/%f/latitude/%f",self.seller_type,loc.coordinate.longitude,loc.coordinate.latitude];
    [manager stopUpdatingLocation];
     [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
 }

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
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
    
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.logistics.text=model.logistics;
    
    RatingBar *bar = [[RatingBar alloc] initWithFrame:CGRectMake(85, 40, 80, 20)];
    [cell addSubview:bar];
    bar.starNumber=model.total_praises;
    bar.enable=NO;
    bar.frame=CGRectMake(85, 40, 60, 20);
    
    if (model.distance<500) {
        cell.street.text=@"<500m";
    }else if (model.distance<1000&model.distance>500) {
        cell.street.text=@"<1km";
    }else if (model.distance>1000&model.distance<2000) {
        cell.street.text=@"<2km";
    }else if (model.distance>2000&model.distance<3000) {
        cell.street.text=@"<3km";
    }else{
        cell.street.text=@"超过3km";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    Public_Seller_info_model_arr_seller_info *model =self.data[row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShowViewController *showVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowViewController"];
    showVic.seller_id=model.seller_id;
    showVic.models=model;
    [self.navigationController pushViewController:showVic animated:YES];
}
-(void)headerRereshing
{
    page =1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
     NSString *agent_id= [NSString stringWithFormat:@"%ld",(long)user.agent_id];
    [self publicSellerInfoWithAgent_id:agent_id andTypeString:typeString andPage:pageString];
    [self.tableview headerEndRefreshing];
}
- (void)footerRereshing
{
    page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
     NSString *agent_id= [NSString stringWithFormat:@"%ld",(long)user.agent_id];
    [self publicSellerInfoWithAgent_id:agent_id andTypeString:typeString andPage:pageString];
    [self.tableview footerEndRefreshing];
    
}

-(void)publicSellerInfoWithAgent_id:(NSString *)agent_id1 andTypeString:(NSString *)typeString1 andPage:(NSString *)pageString{
    [sellerService publicSellerInfoWithAgent_id:agent_id1 anrTypeString:typeString1 inTabBarController:self.tabBarController withDone:^(Public_Seller_info_model_info *model){
        self.data=model.arr_seller;
        
        [self.tableview reloadData];
    }];
    
}
@end
