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
@interface SellerDetailViewController ()
{
    NSString *detail;
    NSString *selerDetail;
}
@end

@implementation SellerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商品提供方介绍";
     self.tableview.autoresizesSubviews=YES;
    detail=@"";
    selerDetail=@"";
    RobService *robService =[[RobService alloc] init];
    [robService sellerInfoWithAgentid:self.agent_id andSeller_type:self.seller_type andSellerid:self.seller_id inRootTabBarController:self.tabBarController withDone:^(Seller_Info_info *model){
        self.object = model.arr_seller[0];
        [self.tableview reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
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
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section =indexPath.section;
    NSInteger row =indexPath.row;
    if (section==0) {
        SellerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.sellerName.text =self.object.seller_name;
        [cell.selerPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.object.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else if(section==1){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        if (row==1) {
            cell.title.font=[UIFont systemFontOfSize:10];
            cell.title.text=[NSString stringWithFormat:@"    %@",self.object.intro];
            cell.topicHeight.constant=[NSString heightWithString:detail font:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(DeviceFrame.size.width-16, 220)]+20;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(section==2){
        RobIndex1_0Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"RobIndex1_0Cell" forIndexPath:indexPath];
        if (row==0) {
            cell.sellerTitle.text=@"热线电话";
            cell.selerDetail.text=self.object.phone;
            cell.selerDetail.font=[UIFont systemFontOfSize:14];
        }else if(row==1){
            cell.sellerTitle.text=@"地      址";
            cell.selerDetail.font=[UIFont systemFontOfSize:12];
            cell.selerDetail.text=self.object.address;
            cell.sellerDetailHeight.constant=[NSString heightWithString:self.object.address font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-97-8, 220)];
        }else if(row==2){
            cell.sellerTitle.text=@"上班时间";
            cell.selerDetail.font=[UIFont systemFontOfSize:14];
            cell.selerDetail.text=self.object.work_time;
            cell.sellerDetailHeight.constant=[NSString heightWithString:self.object.work_time font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(DeviceFrame.size.width-97-8, 220)];
        }else{
            return nil;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(section==3){
        Index0_Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.title.text=@"供抢记录";
        
        return cell;
    }else if (section==4){
        SellerCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SellerCell" forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.sellerName.text=@"冰糖杆";
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
//            if (selerDetail) {
//                statements
//            }
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
        
    }return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
