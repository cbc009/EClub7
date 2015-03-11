//
//  
//  Club
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RobViewController.h"
#import "RobService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "NSString+MT.h"
#import "SharedAction.h"
#import "WebViewController.h"
#import "Status.h"
#import <BmobSDK/Bmob.h>
#import "Index0_1Cell.h"
#import "RobCell.h"
#import "Index0Service.h"
#import "Robuy_Goods.h"
#import <UIImageView+WebCache.h>
#import "RobDetailViewController.h"
@interface RobViewController ()
{
    RobService *robService;
    Index0Service *index0Service;;
    UserInfo *user;
        int count;
    NSMutableArray *timeArray;
    NSMutableArray *timeEndArray;
    NSTimer *timwer;
    
}
@property(nonatomic,assign)NSInteger second1;
@property(nonatomic,strong)NSTimer *timer;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"抢购";
    timeArray=[NSMutableArray new];
    timeEndArray=[NSMutableArray new];
    robService = [[RobService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    index0Service=[[Index0Service alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title=@"乔庄生活馆";
    [robService loadAdverPicWithPos:3 inViewController:self];
    __block RobViewController *aBlockSelf = self;
   
    [robService setRobModelWithLifehallid:user.lifehall_id orGoodsid:@"0" inRootTabBarController:self.tabBarController withDone:^(Robuy_Goods_info *model){
        aBlockSelf.goodNums=model.arr_goods;
        [aBlockSelf.tableView reloadData];
    }];
}


//


////抢
//- (IBAction)buyOrRobAction:(id)sender {
//    [robService robWithToken:user.token andUser_type:user.user_type andRobModel:self.robModel inTabBarController:self.tabBarController withDone:^(Status *model){
//        NSString *message =[NSString stringWithFormat:@"恭喜你在E小区免费抢到%@赶快去告诉朋友吧",self.robModel.name];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抢菜信息" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去告诉朋友", nil];
//        [alertView show];
//        //存储到Bmob后台
//        BmobObject *object = [BmobObject objectWithClassName:@"RobOrder"];
//        [object setObject:user.loginname forKey:@"loginname"];
//        [object setObject:self.robModel.name forKey:@"goodName"];
//        [object setObject:self.robModel.gid forKey:@"goodId"];
//        [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//            //进行操作
//        }];
//    }];
//}

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



//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex==1) {
////        [SharedAction shareWithTitle:_itemNameLabel.text andDesinationUrl:AppDownLoadURL Text:alertView.message andImageUrl:_itemPic InViewController:self];
//    }
//}
//
//- (IBAction)shareAction:(id)sender {
////    [SharedAction shareWithTitle:_itemNameLabel.text andDesinationUrl:AppDownLoadURL Text:@"在E小区中每天都有免费抢菜哦 小伙伴们赶快来" andImageUrl:_itemPic InViewController:self];
//}
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
        return self.goodNums.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    if (indexPath.section==0) {
        Index0_1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Index0_1Cell" forIndexPath:indexPath];
        cell.pageview.imageType = UIImageUrlType;
        cell.pageview.imgUrls = [index0Service namesFromPictures:self.pageviewDatas];
        cell.pageview.titles = [index0Service titlesFromPictures:self.pageviewDatas];
        cell.pageview.urls = [index0Service urlsFromPictures:self.pageviewDatas];
        cell.pageview.martinLiPageScrollViewDelegate = self;
        cell.pageview.isAutoScroll = YES;
        cell.pageview.titleIsHidden = YES;//默认为NO（可选）
        cell.pageview.height = cell.pageviewHeight.constant;
        cell.pageview.pageViewType = MLPageScrollViewAdvertiseMode;//默认是广告模式（可选）
        cell.pageview.timeInterval = 3;//默认自动滚动图片时间为2秒（可选）
        [cell.pageview updatePageViewInSuperView:self.view];
        return cell;
    }else if(indexPath.section==1){
        RobCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RobCell" forIndexPath:indexPath];
        cell.cellNums++;
        Robuy_Goods_arr_goods_info *object = self.goodNums[row];
        [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.goodName.text=object.name;
        cell.goodNum.text=[NSString stringWithFormat:@"抢购数量:%@",object.provider_nums];
        if ([object.discount isEqualToString:@"0.00"]) {
            cell.goodPrice.text=[NSString stringWithFormat:@"E:%@",object.point];
        }else{
            cell.goodPrice.text=[NSString stringWithFormat:@"元:%@",object.discount];
        }
        cell.marketPrice.text=[NSString stringWithFormat:@"￥:%@",object.price];
        cell.saleNum.text =[NSString stringWithFormat:@"以抢:%@",object.actual_nums];
        cell.starttime=object.start_seconds;
        cell.endtime=object.end_seconds;
        if (object.start_seconds >-1) {
            cell.times.text=[NSString stringWithFormat:@"距离开始还有:%@",[self toDetailTime:object.start_seconds]];
            [timeArray addObject:[NSString stringWithFormat:@"%ld",(long)object.start_seconds]];
            cell.robNow.backgroundColor=[UIColor redColor];
        }else{
            if (object.end_seconds>-1) {
                [timeEndArray addObject:[NSString stringWithFormat:@"%ld",(long)object.end_seconds]];
                cell.times.text=[NSString stringWithFormat:@"距离结束还有:%@",[self toDetailTime:object.end_seconds]];
                cell.robNow.backgroundColor=[UIColor redColor];
            }else{
                cell.times.text=@"今天抢购已结束";
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
    Robuy_Goods_arr_goods_info *robuyGood = [self.goodNums objectAtIndex:row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    RobDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"RobDetailViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.robGoodsMOdel = robuyGood;

}
@end
