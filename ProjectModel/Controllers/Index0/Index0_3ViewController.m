//
//  Index0_3ViewController.m
//  Club
//
//  Created by Gao Huang on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index0_3ViewController.h"
#import "BuyGoodTypeCell.h"
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

@interface Index0_3ViewController ()
{
    Index0Service *index0Service;
    BuyService *buyService;
}
@end

@implementation Index0_3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    self.title=user.lifehall_name;
    index0Service = [[Index0Service alloc] init];
    if (![[sharedData loginStatus] isEqualToString:@"yes"]) {
        [SharedAction presentLoginViewControllerInViewController:self];
    }else{
        //需要重新加载userDefaults的数据（可能数据库的数据会经常变化）
        [index0Service loadUserDefaultsInViewController:self];
    }

    self.collectionDatas = [NSArray arrayWithObjects:@"抢菜",@"充值",@"秒杀",@"抽奖",@"团购",@"兑换",@"购物车",@"钱包", nil];
    self.collectionImgs = [NSArray arrayWithObjects:@"rob.jpg",@"recharge.jpg",@"seckill.jpg",@"lotterydraw.jpg",@"team_buy.jpg",@"exchange.jpg",@"buy.jpg",@"wallet.jpg", nil];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==1){
        return 1;
    }else{
        return self.goodTypes.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section==0) {
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
    }else if(section==1){
        Index0_2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Index0_2Cell" forIndexPath:indexPath];
        MainItemLayout *layout = [[MainItemLayout alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.collectionview.collectionViewLayout = layout;


        return cell;
    }else{
        BuyGoodTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyGoodTypeCell" forIndexPath:indexPath];
        NSInteger row = indexPath.row;
        Goods_type_goods_type *goods_type = self.goodTypes[row];
        NSArray *subtypes = goods_type.subtype;
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,goods_type.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.firstType.text = goods_type.name;
        cell.secondType.text = [self subtypeStringFromArray:subtypes];
        return cell;

    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    NSInteger section = indexPath.section;
    if (section==0) {
        return 110;
    }else if (section==1){
        return 210;
    }else{
        return 109;
    }
}
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger )section
//{
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        return 8;
    }
}

/*
 二级目录的组合
 */
-(NSString *)subtypeStringFromArray:(NSArray *)subtypes{
    NSMutableString *subtypeString = [[NSMutableString alloc] initWithString:@""];
    for (Goods_type_subType *subtype in subtypes) {
        if (subtype==subtypes.lastObject) {
            [subtypeString appendString:[NSString stringWithFormat:@"%@",subtype.name]];
        }else{
            [subtypeString appendString:[NSString stringWithFormat:@"%@/",subtype.name]];
        }
    }
    return subtypeString;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        Goods_type_goods_type *goods_type = self.goodTypes[row];
        NSArray *subtypes = goods_type.subtype;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        GoodsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GoodsViewController"];;
        viewController.subtypes = subtypes;
        viewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionDatas.count;
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
        //抢菜
        storyboardName = @"Main";
        identifier = @"RobViewController";
    }else if (row==1){
        storyboardName = @"Index3";
        identifier = @"CreatePayViewController";
    }else if(row==2){
        storyboardName = @"Index0";
        identifier = @"KillListViewController";
    }else if(row==3){
        storyboardName = @"Index1";
        identifier = @"Index1ViewController";
    }else if(row==4){
        storyboardName = @"Index0";
        identifier = @"GroupsViewController";
    }else if(row==5){
        storyboardName = @"Index0";
        identifier = @"PointViewController";
    }else if(row==6){
        storyboardName = @"Index0";
        identifier = @"PurchaseCarItemsViewController";
    }else if(row==7){
        storyboardName = @"Index3";
        identifier = @"MyWalletViewController";
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

#pragma LoginViewControllerDelegate
-(void)loginSuccessedActionWithViewController:(UIViewController *)viewController{
    [viewController.navigationController dismissViewControllerAnimated:YES completion:nil];
    SharedData *sharedData = [SharedData sharedInstance];
    buyService = [[BuyService alloc] init];
    [buyService loadGoodTypesWithToken:sharedData.user.token andUser_type:sharedData.user.user_type InViewController:self];
    [index0Service loadAdverPicWithPos:1 andCity:sharedData.user.city inViewController:self];
}
@end
