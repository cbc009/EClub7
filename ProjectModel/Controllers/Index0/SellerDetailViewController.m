//
//  SellerDetailViewController.m
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "SellerDetailViewController.h"
#import "RobIndex1_0Cell.h"
#import "SellerCell.h"
#import "Index0_Cell.h"
#import "NSString+MT.h"
#import "Seller_Info.h"
#import "RobService.h"
#import <UIImageView+WebCache.h>
#import "Robuy_Goods.h"
#import "PastItemsTableViewController.h"
@interface SellerDetailViewController ()
{
    NSString *detail;
    NSString *selerDetail;
    UserInfo *user;
    NSInteger cellRow;
}
@end

@implementation SellerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商品提供方";
     self.tableview.autoresizesSubviews=YES;
    self.tableview.showsVerticalScrollIndicator =NO;
    self.tableview.tableFooterView =[UIView new];
    detail=@"";
    cellRow=0;
    selerDetail=@"";
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    self.lifeHall_id =[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
//    RobService *robService =[[RobService alloc] init];
//    [robService sellerInfoWithAgentid:self.agent_id andSeller_type:self.seller_type andSellerid:self.seller_id inRootTabBarController:self.tabBarController withDone:^(Seller_Info_info *model){
//        self.object = model.arr_seller[0];
//        [robService setRobModelWithLifehallid:self.lifeHall_id orDetail:[NSString stringWithFormat:@"seller_id/%@",self.seller_id] inRootTabBarController:self.tabBarController withDone:^(Robuy_Goods_info *model){
//            self.goodeArray=model.arr_goods;
//            cellRow=5;//这个地方是控制就是刚进入该页面的时候不显示东西没别的意思
//            [self.tableview reloadData];
//        }];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return cellRow;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0){
        return 1;
    }else if (section==1){
        return 2;
    }else if(section==2){
        return 3;
    }else if(section==3){
        return 1;
    }else {
        return self.goodeArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section =indexPath.section;
    NSInteger row =indexPath.row;
    if (section==0) {
        SellerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.sellerName.text =self.object.seller_name;
        cell.sellerName.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
        [cell.selerPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.object.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else if(section==1){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        if (row==1) {
            cell.title.font=[UIFont systemFontOfSize:10];
            cell.title.text=[NSString stringWithFormat:@"    %@",self.object.intro];
            cell.topicHeight.constant=[NSString heightWithString:detail font:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(DeviceFrame.size.width-16, 220)]+20;
        }if (row==0) {
            cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(section==2){
        RobIndex1_0Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"RobIndex1_0Cell" forIndexPath:indexPath];
        if (row==0) {
            cell.sellerTitle.text=@"热线电话";
            cell.sellerTitle.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
            cell.selerDetail.text=self.object.phone;
            cell.selerDetail.font=[UIFont systemFontOfSize:14];
        }else if(row==1){
            cell.sellerTitle.text=@"地      址";
            cell.sellerTitle.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
            cell.selerDetail.font=[UIFont systemFontOfSize:12];
            cell.selerDetail.text=self.object.address;
            cell.sellerDetailHeight.constant=[NSString heightWithString:self.object.address font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-97-8, 220)];
        }else if(row==2){
            cell.sellerTitle.text=@"上班时间";
            cell.sellerTitle.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
            cell.selerDetail.font=[UIFont systemFontOfSize:14];
            cell.selerDetail.text=self.object.work_time;
            cell.sellerDetailHeight.constant=[NSString heightWithString:self.object.work_time font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(DeviceFrame.size.width-97-8, 220)];
        }else{
            return nil;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(section==3){
        RobIndex1_0Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"RobIndex1_0Cell" forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.sellerTitle.text=@"供抢记录";
        cell.selerDetail.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
        cell.selerDetail.text=@"            更多供抢记录";
        return cell;
    }else if (section==4){
        SellerCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SellerCell" forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
         Robuy_Goods_arr_goods_info *object = self.goodeArray[row];
        [cell.selerPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.sellerName.text=object.name;
        return cell;
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    NSInteger section = indexPath.section;
    NSInteger row =indexPath.row;
    if (section==0||section==4) {
        return 87;
    }else if (section==1){
        if (row==1) {
            return [NSString heightWithString:detail font:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(DeviceFrame.size.width-16, 220)]+20;
        }else{
            return 34;
        }
    }else if(section==2){
        if (row==0) {
             return 40;
        }else if (row==1) {

            return [NSString heightWithString:self.object.address font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-97-8, 220)]+10;
        } else{
            return [NSString heightWithString:self.object.work_time font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(DeviceFrame.size.width-97-8, 220)]+10;
        }
    }else{
            return 34;
        }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2||section==3) {
        return 8;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==3) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        PastItemsTableViewController *pastItemsTableViewController = [storyBoard instantiateViewControllerWithIdentifier:@"PastItemsTableViewController"];
        pastItemsTableViewController.seller_id=self.seller_id;
        [self.navigationController pushViewController:pastItemsTableViewController animated:YES];
    }
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
