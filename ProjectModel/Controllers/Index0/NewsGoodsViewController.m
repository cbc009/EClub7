//
//  NewsGoodsViewController.m
//  Club
//
//  Created by MartinLi on 15-4-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "NewsGoodsViewController.h"
#import "ItemCell.h"
#import "BuyService.h"
#import "Login_latest_model.h"
#import <UIImageView+WebCache.h>
#import "ItemDetailViewController.h"
#import "TypeGoods.h"
@interface NewsGoodsViewController ()
{
    BuyService *buyService;
    UserInfo *user;
    NSArray *datas;
}
@end

@implementation NewsGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
//    self.navigationController.navigationBar.leftItemsSupplementBackButton=NO;
    [self.navigationController.navigationBar.backItem setTitle:@"首页"];
    
//    [self.navigationController.navigationBar.barStyle=]
    buyService=[BuyService new];
    [buyService loginLatestwithAgentId:user.agent_id inTabBarController:self.tabBarController withDone:^(Login_latest_model_info *model){
        datas=model.arr_goods;
        [self.tablewView reloadData];
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    Login_latest_model_Arr_Goods_Info *model=datas[row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.pastPrice.text = [NSString stringWithFormat:@"原价:%@元/%@",model.price,model.unit];
    cell.currenPrice.text = [NSString stringWithFormat:@"%@元/%@",model.discount,model.unit];
    cell.discout.text = [NSString stringWithFormat:@"%0.1f折",[model.discount floatValue]/[model.price floatValue]*10];
    cell.people.text = [NSString stringWithFormat:@"已购买人数%@",model.actual_nums];
    cell.name.text = model.goods_name;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    return 123;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSInteger row =indexPath.row;
      Login_latest_model_Arr_Goods_Info *model=datas[row];
    [buyService goods_Goods_InfoWithGoodId:model.goods_id nTabBarController:self.tabBarController withDone:^(Type_Goods_info *model){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index4" bundle:nil];
        ItemDetailViewController *target = [storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];
        target.goodModel=model.goods;
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }];
    
}
@end
