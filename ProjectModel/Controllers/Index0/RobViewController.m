//
//  
//  Club
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RobViewController.h"
#import "SellerService.h"
#import "Seller_Seller_Goods.h"
#import "RobService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "NSString+MT.h"
#import "SharedAction.h"
#import "WebViewController.h"
#import "Status.h"
#import "Index0_3Cell.h"
#import "RobCell.h"
#import "Index0Service.h"
#import "Robuy_Goods.h"
#import <UIImageView+WebCache.h>
#import "RobDetailViewController.h"
#import "MJRefresh.h"
#import "ChangeLifeService.h"
#import "Public_lifehall.h"
@interface RobViewController ()<RMPickerViewControllerDelegate>
{
    RobService *robService;
    SellerService *sellerServicel;
    Index0Service *index0Service;
    UserInfo *user;
        int count;
    NSMutableArray *timeArray;
    NSMutableArray *timeEndArray;
    NSTimer *timwer;
    NSInteger page;
    NSInteger ChangeUp;//防止重复点击切换生活馆按钮出现多个pickview
    ChangeLifeService *changeLifeService;
}
@property(nonatomic,assign)NSInteger second1;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *components;
@property (nonatomic,strong)NSMutableArray *lifeIdArray;

@end

@implementation RobViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.pickerVC removeFromParentViewController];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    ChangeUp=0;
    sellerServicel=[SellerService new];
    self.datas=[NSMutableArray new];
    timeArray=[NSMutableArray new];
    timeEndArray=[NSMutableArray new];
    self.components=[NSMutableArray new];
    self.lifeIdArray=[NSMutableArray new];
    robService = [[RobService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.goodNums =[NSMutableArray new];
    index0Service=[[Index0Service alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title=user.lifehall_name;
    [robService loadAdverPicWithPos:3 inViewController:self];
    [SharedAction setupRefreshWithTableView:self.tableView toTarget:self];
    [self.tableView headerBeginRefreshing];
    
    [SharedAction removeLocalPushNotificationWithType:@"rob"];//这里要注意 这里是取消现在用户手机中的抢购本地推送推送
    
}



- (IBAction)changeLifeHall:(id)sender {
    if (ChangeUp==0) {
        ChangeUp=1;
        changeLifeService =[[ChangeLifeService alloc] init];
        __block RobViewController *blockSelf =self;
        [changeLifeService publiclifehallWithagentid:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andLifehallId:[NSString stringWithFormat:@"%ld",(long)user.lifehall_id] inTabBarController:blockSelf.tabBarController withDone:^(Public_Lifehall_INfo *model){
            [self setPickwithDatas:model.arr_lifehall];
        }];
    }
}
-(void)setPickwithDatas:(NSArray *)datas{
    self.pickerVC = [RMPickerViewController pickerController];
    count = (int)datas.count;
    for (NSInteger i=0; i<count; i++) {
        Public_Lifehall_INfo_arr_lifehall *object =datas[i];
        [self.components addObject:object.lifehall_name];
        [self.lifeIdArray addObject:object.lifehall_id];
    }
    self.pickerVC.delegate = self;
    self.pickerVC.titleLabel.text = @"选择";
    self.pickerVC.disableBlurEffects = YES;
    [self.pickerVC show];
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
        NSLog(@"暂无url");
    }
}
/*
 秒转化成详细时间
 */
-(NSString *)toDetailTime:(NSInteger)seconds{
    int second = seconds % 60;
    int minute = (seconds-second)/60%60;
    int hour = (seconds-second-minute*60)/60/60%24;
//    int day = (seconds-second-minute*60-hour*60*24)/60/60/24%24;
    NSString *detailTime = [NSString stringWithFormat:@"%d:%d:%d",hour,minute,second];
    return detailTime;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0){
        return 1;
    }else{
        return self.datas.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    if (indexPath.section==0) {
        Index0_3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Index0_3Cell" forIndexPath:indexPath];
        self.tableView.bounces=YES;
        cell.pageview.imageType = UIImageUrlType;
        cell.pageview.imgUrls = [index0Service namesFromPictures:self.pageviewDatas];
        cell.pageview.titles = [index0Service titlesFromPictures:self.pageviewDatas];
        cell.pageview.urls = [index0Service urlsFromPictures:self.pageviewDatas];
        cell.pageview.martinLiPageScrollViewDelegate = self;
        cell.pageview.isAutoScroll = NO;
        cell.pageview.titleIsHidden = YES;//默认为NO（可选）
        cell.pageview.height = cell.pageViewHeight.constant;
        cell.pageview.pageViewType = MLPageScrollViewAdvertiseMode;//默认是广告模式（可选）
        cell.pageview.timeInterval = 3;//默认自动滚动图片时间为2秒（可选）
        [cell.pageview updatePageViewInSuperView:self.view];
        return cell;
    }else if(indexPath.section==1){
        RobCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RobCell" forIndexPath:indexPath];
        cell.cellNums++;
        Seller_Seller_Goods_arr_goods_info *object = self.datas[row];
        [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.goodName.text=object.goods_name;
        cell.goodNum.text=[NSString stringWithFormat:@"抢购数量:%@",object.provider_nums];
        if ([object.discount isEqualToString:@"0.00"]) {
            cell.goodPrice.text=[NSString stringWithFormat:@"%@E币",object.point];
        }else{
            cell.goodPrice.text=[NSString stringWithFormat:@"￥:%@",object.discount];
        }
        cell.marketPrice.text=[NSString stringWithFormat:@"￥:%@",object.price];
        cell.saleNum.text =[NSString stringWithFormat:@"已抢:%@",object.actual_nums];
        cell.starttime=[object.start_seconds integerValue];
        cell.endtime=[object.end_seconds integerValue];
        if ([object.start_seconds integerValue]>-1) {
            cell.times.text=[NSString stringWithFormat:@"距离开始还有:%@",[self toDetailTime:[object.start_seconds integerValue]]];
            [timeArray addObject:[NSString stringWithFormat:@"%ld",(long)object.start_seconds]];
            cell.robNow.backgroundColor=[UIColor redColor];
        }else{
            if ([object.end_seconds integerValue]>-1) {
                [timeEndArray addObject:[NSString stringWithFormat:@"%ld",(long)object.end_seconds]];
                cell.times.text=[NSString stringWithFormat:@"距离结束还有:%@",[self toDetailTime:[object.end_seconds integerValue]]];
                cell.robNow.backgroundColor=[UIColor redColor];
            }else{
                cell.times.text=@"今天抢购已结束";
                [cell.robNow setTitle:@"抢购结束" forState:UIControlStateNormal];
                cell.robNow.backgroundColor=[UIColor grayColor];
            }
            
        }
        [cell.goodNum.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
        [cell.goodNum.layer setBorderWidth:0.5];   //边框宽度
        cell.robNow.layer.cornerRadius = 3;
        return cell;
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    NSInteger section = indexPath.section;
    if (section==0) {
        return 123;
    }else if (section==1){
        return 125;
    }else {
        return 0;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    Seller_Seller_Goods_arr_goods_info *robuyGood = [self.datas objectAtIndex:row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    RobDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"RobDetailViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.robGoodsMOdel = robuyGood;

}
-(void)panInViewControllerWithType:(BOOL)type{
    self.tableView.bounces=type;
}

-(void)headerRereshing
{
    page =1;
    [self loadSellerSellerGoodsTypeWithPage:page andType:0];
}
- (void)footerRereshing
{
    page++;
    [self loadSellerSellerGoodsTypeWithPage:page andType:1];
}

-(void)loadSellerSellerGoodsTypeWithPage:(NSInteger)pages andType:(NSInteger)type{
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)pages];
    [sellerServicel sellerSellerGood_typesWith:@"3" andAgentId:[NSString stringWithFormat:@"%ld",(long)user.agent_id]  andSeller_id:@"0" andLifehall_id:[NSString stringWithFormat:@"%ld",(long)user.lifehall_id] andPage:pageString inTabBarController:self.tabBarController withDone:^(Seller_Seller_Goods_info*model){
        if (type==0) {
            self.datas=(NSMutableArray*)model.arr_goods;
            [self.tableView headerEndRefreshing];
        }else{
            [self.datas addObjectsFromArray:model.arr_goods];
            [self.tableView footerEndRefreshing];
        }
        [self.tableView reloadData];
    }];
}
#pragma mark - RMPickerViewController Delegates
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   
    return [self.components count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.components[row];
}

- (void)pickerViewController:(RMPickerViewController *)vc didSelectRows:(NSArray *)selectedRows {
    NSString *value = [self valueFromSelectedRows:selectedRows andComponents:self.components];
    NSString *lifeIDValue =[self valueFromSelectedRows:selectedRows andComponents:self.lifeIdArray];
   
    [self changeLifeId:lifeIDValue andLifeHallName:value];
}
- (void)pickerViewControllerDidCancel:(RMPickerViewController *)vc{
    ChangeUp=0;
}
-(NSString *)valueFromSelectedRows:(NSArray *)selectedRows andComponents:(NSArray *)components{
    NSMutableString *value = [[NSMutableString alloc] init];
    for (int i=0; i<selectedRows.count; i++) {
        NSString *value = components[i];
        return value;
         }
    return value;
}
-(void)changeLifeId:(NSString *)lifeHallId andLifeHallName:(NSString *)lifehallName{
    user.lifehall_id=[lifeHallId integerValue];
    user.lifehall_name=lifehallName;
    self.title=lifehallName;
    ChangeUp=0;
    [self headerRereshing];
}
@end
