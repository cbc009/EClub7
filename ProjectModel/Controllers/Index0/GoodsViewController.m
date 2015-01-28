//
//  GoodsViewController.m
//  Club
//
//  Created by Gao Huang on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "GoodsViewController.h"
#import "Goods_type.h"
#import "ItemCell.h"
#import <UIImageView+WebCache.h>
#import "Type_goods.h"
#import "BuyService.h"
#import "Goods_type.h"
#import "MJRefresh.h"
#import "ItemDetailViewController.h"
#import "PurchaseCarItemsViewController.h"
#import "MLFloatButton.h"
#import "SVProgressHUD.h"
#import "Member_Login.h"
@interface GoodsViewController ()<MLFloatButtonDelegate>
{
    BuyService *buyService;
    UserInfo *user;
    int page;
    NSString *subtypeId;
    MLFloatButton *floatButton;
}
@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    buyService = [[BuyService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    _tableview.showsVerticalScrollIndicator =NO;
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setSegmentedControl:self.seg WithArray:self.subtypes];
    Goods_type_subType *subtype = self.subtypes[0];
    subtypeId = subtype.subid;
    page = 1;
    self.title = @"商城";
    [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    float width = 50;
    floatButton = [MLFloatButton loadFromNibWithFrame:CGRectMake(DeviceFrame.size.width-width, DeviceFrame.size.height/2, width, width)  addTarget:self InSuperView:self.view];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    [self.tableview headerEndRefreshing];
}

-(void)buttonTouchAction
{
    PurchaseCarItemsViewController *purchaseCar = [self.storyboard instantiateViewControllerWithIdentifier:@"PurchaseCarItemsViewController"];
    [self.navigationController pushViewController:purchaseCar animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goodCellToDetail"]) {
        NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
        NSInteger row = indexPath.row;
        Type_goods_good *good = self.datas[row];
        ItemDetailViewController *viewController = segue.destinationViewController;
        viewController.goodModel = good;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    Type_goods_good *model = self.datas[row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.pastPrice.text = [NSString stringWithFormat:@"原价:%@元/%@",model.price,model.unit];
    cell.currenPrice.text = [NSString stringWithFormat:@"%@元/%@",model.discount,model.unit];
    cell.discout.text = [NSString stringWithFormat:@"%0.1f折",[model.discount floatValue]/[model.price floatValue]];
    cell.people.text = [NSString stringWithFormat:@"已购买人数%@",model.nums];
    if (model.goods_new == 2) {
        cell.goodimage.image= [UIImage imageNamed:@"shop_new_tag3"];
    }else if(model.goods_new == 3){
        cell.goodimage.image= [UIImage imageNamed:@"special_selling"];
    }else{
        cell.goodimage.image= nil;
    }
    cell.name.text = model.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
if (alertView.tag==5) {
    if(buttonIndex==1){
        [SharedAction loginAggane];
        NSArray *viewControllers = self.navigationController.viewControllers;
        [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
    }
}else if (alertView.tag==2) {
    if(buttonIndex==2){
        NSLog(@"dd");
    }
    }
}

- (IBAction)segAction:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    Goods_type_subType *subtype = self.subtypes[index];
    subtypeId = subtype.subid;
    page = 1;
    [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
}

/*
 设置segmentedControl
 */
-(void)setSegmentedControl:(UISegmentedControl *)seg WithArray:(NSArray *)array{
    NSInteger num = array.count;
    if (num<=1) {
        self.segment.constant=0;
        [self.seg setHidden:YES];
    }else{
        for (NSInteger i=0; i<num; i++) {
            Goods_type_subType *subtype = array[i];
            if (i<2) {
                [seg setTitle:subtype.name forSegmentAtIndex:i];
            }else{
                [seg insertSegmentWithTitle:subtype.name atIndex:i animated:YES];
            }
        }
    }
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    page = 1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [SVProgressHUD show];
    [buyService type_goodsWithToken:user.token andUser_type:user.user_type andSubtypeId:subtypeId andPageString:pageString inTabBarController:self.tabBarController withDone:^(Type_goods_info *model){
        self.datas =(NSMutableArray *)model.goods;
        [self.tableview reloadData];
        [self.tableview headerEndRefreshing];
        
    }];
}

- (void)footerRereshing
{
    page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [buyService type_goodsWithToken:user.token andUser_type:user.user_type andSubtypeId:subtypeId andPageString:pageString inTabBarController:self.tabBarController withDone:^(Type_goods_info *model){
        [self.datas addObjectsFromArray:model.goods];
        [self.tableview reloadData];
        [self.tableview footerEndRefreshing];
    }];
}
@end
