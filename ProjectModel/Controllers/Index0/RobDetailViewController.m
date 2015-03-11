//
//  RobDetailViewController.m
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RobDetailViewController.h"
#import "RobIndex1_Cell.h"
#import "Index0_Cell.h"
#import "WebCell.h"
#import "RobTitleCell.h"
#import "RobedRecordsViewController.h"
#import "NSString+MT.h"
#import <UIImageView+WebCache.h>
#import "SellerDetailViewController.h"
@interface RobDetailViewController ()

@end

@implementation RobDetailViewController
{
    UserInfo *user;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"抢购详情";
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    self.tableView.autoresizesSubviews=NO;
    self.robNowButton.layer.cornerRadius=5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0){
        return 1;
    }else if (section==1){
        return 1;
    }else if(section==2){
        return 1;
    }else if(section==3){
        return 2;
    }else if(section==4){
        return 4;
    }else if(section==5){
        return 1;
    }else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSInteger section =indexPath.section;
     NSInteger row =indexPath.row;
    if (section==0) {
        RobTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RobTitleCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.goodName.text=self.robGoodsMOdel.name;
        cell.saleNum.text=[NSString stringWithFormat:@"以抢%@",self.robGoodsMOdel.actual_nums];
        if ([self.robGoodsMOdel.discount isEqualToString:@"0.00"]) {
            cell.price.text=[NSString stringWithFormat:@"E:%@",self.robGoodsMOdel.point];
        }else{
            cell.price.text=[NSString stringWithFormat:@"元:%@",self.robGoodsMOdel.discount];
        }
        cell.goodNum.text =[NSString stringWithFormat:@"抢购数量:%@",self.robGoodsMOdel.provider_nums];
        cell.starttime=self.robGoodsMOdel.start_seconds;
        cell.endtime=self.robGoodsMOdel.end_seconds;
        cell.marketPrice.text=[NSString stringWithFormat:@"￥:%@",self.robGoodsMOdel.price];
        [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.robGoodsMOdel.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
        [cell.goodNum.layer setBorderWidth:1];   //边框宽度
        [cell.goodNum.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
        return cell;
    }else if(section==1){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.title.textColor=[UIColor blackColor];
        cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
        cell.title.text=@"抢购商品提供方";
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(section==2){
        RobIndex1_Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"RobIndex1_Cell" forIndexPath:indexPath];
        cell.sellerName.text=self.robGoodsMOdel.seller_name;
        cell.sellerDetail.text =self.robGoodsMOdel.seller_intro;
        [cell.sellerPIc sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.robGoodsMOdel.seller_picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else if (section==3){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
         cell.accessoryType=UITableViewCellAccessoryNone;
        if (row==0) {
            cell.title.textColor=[UIColor blackColor];
            cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
            cell.title.text=@"抢购时间";
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }else{
        cell.title.font=[UIFont systemFontOfSize:12];
        cell.title.textColor=[UIColor grayColor];
        cell.title.text=self.robGoodsMOdel.robuy_time;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else if(section==4){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
        if (row==0) {
            cell.title.textColor=[UIColor blackColor];
            cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
            cell.title.text=@"领取方式";
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }else if(row==1){
            cell.title.font=[UIFont systemFontOfSize:12];
            cell.title.text=self.robGoodsMOdel.receive_from;
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.title.textColor=[UIColor grayColor];
        }else if (row==2) {
            cell.title.textColor=[UIColor blackColor];
            cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
            cell.title.text=@"领取地址";
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }else{
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.title.textColor=[UIColor grayColor];
            cell.title.font=[UIFont systemFontOfSize:12];
            cell.title.text =self.robGoodsMOdel.receive_address;
        }
        return cell;
    }else if(section==5){
        Index0_Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.title.textColor=[UIColor blackColor];
        cell.title.text=@"查看抢购名单";
        cell.title.font=[UIFont fontWithName:@"TrebuchetMS-Bold" size:17];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        WebCell *cell =[tableView dequeueReusableCellWithIdentifier:@"WebCell" forIndexPath:indexPath];
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    NSInteger section = indexPath.section;
    if (section==0) {
        return 308;
    }else if (section==2){
        return 82;
    }else if (section==6) {
        return 70;
    }else{
        return 34;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2||section==0) {
        return 0;
    }else{
        
    }return 8;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==5) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        RobedRecordsViewController *robRecodVic = [storyBoard instantiateViewControllerWithIdentifier:@"RobedRecordsViewController"];
        [self.navigationController pushViewController:robRecodVic animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)robNow:(id)sender {
    NSLog(@"now");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"sellerPush"]) {
        SellerDetailViewController *viewController = segue.destinationViewController;
        viewController.agent_id=[NSString stringWithFormat:@"%ld",(long)user.agent_id];
        viewController.seller_id=self.robGoodsMOdel.seller_id;
    }else if([segue.identifier isEqualToString:@"sellerPush"]){
}
}
- (IBAction)share:(id)sender {
    NSString *sharurl = [NSString stringWithFormat:Robuy_Share_URL,self.robGoodsMOdel.goods_id];
   [SharedAction shareWithTitle:self.robGoodsMOdel.name andDesinationUrl:sharurl Text:self.robGoodsMOdel.name andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.robGoodsMOdel.bigpicture] InViewController:self];
}
@end
