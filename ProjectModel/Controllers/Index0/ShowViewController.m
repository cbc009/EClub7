//
//  ShowViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShowViewController.h"
#import "ShowDetailViewController.h"
#import "ShoopGoodsViewController.h"
#import <UIImageView+WebCache.h>
#import "RemarkViewController.h"
 #import "Seller_Seller_Goods.h"
#import "NSString+MT.h"
#import "SellerService.h"
#import "Shoop_0Cell.h"
#import "Shoop_1Cell.h"
#import "Shoop_2Cell.h"
#import "Shoop_3Cell.h"
#import "Shoop_4Cell.h"
#import "Index0_Cell.h"
#import "RatingBar.h"
@interface ShowViewController ()<ShowMoreItemsCellDelegate,Shoop_3Delegate>
{
    NSString *identifer;
    UINib *nib;
    SellerService *sellerService;
    UserInfo *user;
}
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    sellerService =[SellerService new];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 5;
            break;
        default:
            break;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section=indexPath.section;
    NSInteger row =indexPath.row;
    switch (section) {
        case 0:
            return 105;
            break;
        case 1:
            return 136;
            break;
        case 2:
            return 41;
            break;
        case 3:
            if (row==0) {
                return 39;
            }else{
                return [NSString heightWithString:self.models.intro font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-16, 300)]+10;
            }
            break;
        case 4:
            if (row==0) {
                return 33;
            }else{
             return 125;
            }
            break;
            
        default:
            break;
    }
    return 105;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section=indexPath.section;
    NSInteger row =indexPath.row;
    if (section==0) {
        Shoop_0Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_0Cell" forIndexPath:indexPath];
        cell.sellerName.text=self.models.seller_name;
       [cell.picture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.models.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.totle.text=[NSString stringWithFormat:@"%ld分",(long)self.models.total_praises];
        RatingBar*bar = [[RatingBar alloc] initWithFrame:CGRectMake(80, 50,100, 20)];
        bar.starNumber=self.models.total_praises;
        bar.enable=NO;
        [cell addSubview:bar];
        bar.frame=CGRectMake(cell.frame.origin.x+145,65,100, 20);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
         return cell;
    }else if(section==1){
        Shoop_1Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_1Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [sellerService sellerSellerGood_typesWith:@"1" andSeller_id:self.models.seller_id andLifehall_id:[NSString stringWithFormat:@"%ld",(long)user.lifehall_id] andPage:@"1" inTabBarController:self.tabBarController withDone:^(Seller_Seller_Goods_info*model){
            cell.datas=model.arr_goods;
            [cell.collection reloadData];
        }];
        cell.delegate = self;
        return cell;
    }else if (section==3){
        Index0_Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.title.text=@"简介";
        }else{
            cell.title.text=self.models.intro;
            cell.topicHeight.constant=[NSString heightWithString:self.models.intro font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-16, 300)];
        }
        return cell;
    }else if (section==2){
        Shoop_2Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.phonePic.image=[UIImage imageNamed:@"phone"];
            cell.phone.text=self.models.phone;
        }else if(row==1){
            cell.phonePic.image=[UIImage imageNamed:@"time"];
            cell.phone.text=self.models.work_time;
        }else{
            cell.phonePic.image=[UIImage imageNamed:@"place"];
            cell.phone.text=self.models.address;
            cell.phone.font=[UIFont systemFontOfSize:12];
        }
        return cell;
    }else if(section==4){
        if (row==0) {
            Shoop_3Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_3Cell" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.delegate=self;
            return cell;
        }else{
            Shoop_4Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_4Cell" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 8;
}
-(void)moreItmes:(id)sender InCell:(UITableViewCell *)cell{
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShowDetailViewController *ShowDetailVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowDetailViewController"];
    [self.navigationController pushViewController:ShowDetailVic animated:YES];
}
-(void)pushShoopsGoodVicIncell:(UITableViewCell *)cell{
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShoopGoodsViewController *shoopGoodVic=[storBoard instantiateViewControllerWithIdentifier:@"ShoopGoodsViewController"];
    [self.navigationController pushViewController:shoopGoodVic animated:YES];
}
-(void)pushRemarkWithsender:(id)sender inCell:(Shoop_3Cell*)cell{
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    RemarkViewController *remarkVIC=[storBoard instantiateViewControllerWithIdentifier:@"RemarkViewController"];
    remarkVIC.models=self.models;
   [self.navigationController pushViewController:remarkVIC animated:YES];

}
@end
