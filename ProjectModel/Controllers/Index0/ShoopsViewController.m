//
//  ShoopsViewController.m
//  Club
//
//  Created by MartinLi on 15-3-25.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShoopsViewController.h"
#import "ShoopsCell.h"
#import "ShoopDetailViewController.h"
#import "SellerService.h"
#import "Public_Seller.h"
#import "Seller_Seller_Goods.h"
#import <UIImageView+WebCache.h>
@interface ShoopsViewController ()
{
    SellerService *sellerService;
    UserInfo *user;
    NSArray *distanceArray0;
}
@end

@implementation ShoopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商户类型";
    sellerService=[SellerService new];
    SharedData *shareData =[SharedData sharedInstance];
    user =shareData.user;
    self.tableview.backgroundColor=[SharedAction colorWithHexString:@"#f2f2f2"];//设置背景颜色
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    NSString *typeString=[NSString stringWithFormat:@"agent_id/%ld",(long)user.agent_id];//获取商户类型所有的
    [sellerService publickSellerListWithTypeString:typeString inTabBarController:self.tabBarController withDone:^(Public_Seller_info *model){
        self.data=model.arr_seller_type;
        distanceArray0=model.arr_distance;
        [self.tableview reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      NSInteger row =indexPath.row;
    ShoopsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ShoopsCell" forIndexPath:indexPath];
    cell.backgroundColor=[SharedAction colorWithHexString:@"#f2f2f2"];
    Public_Seller_arr_seller_type_info *object=self.data[row];
    cell.fatherName.text=object.seller_type_name;
    if (![object.sub_type isEqualToArray:@[]]) {
        //子类名拼成一个字符串用的
        NSString *sonName;
        sonName=@"";
        for (int i=0; i<object.sub_type.count; i++) {
            Public_Seller_sub_type_info *model =object.sub_type[i];
            sonName =[NSString stringWithFormat:@"%@ %@",sonName,model.sub_type_name];
        }
        cell.sonName.text=sonName;
    }else{
        cell.sonName.hidden=YES;
    }
     [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
//    cell.sonNam
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}
//选择一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShoopDetailViewController *shoopDetailVic=[storBoard instantiateViewControllerWithIdentifier:@"ShoopDetailViewController"];
    //把所有的分类一起传过去
    shoopDetailVic.cateArray=self.data;
    shoopDetailVic.distanceArray=distanceArray0;
    shoopDetailVic.index=row;
    Public_Seller_arr_seller_type_info *object=self.data[row];
    
//    shoopDetailVic.models=self.data[row];//这里的models就是用来传一组数据过去的
    shoopDetailVic.seller_type=object.seller_type;//seller_type是商家分类
    [self.navigationController pushViewController:shoopDetailVic animated:YES];
}


@end
