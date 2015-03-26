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
#import "Shoop_0Cell.h"
#import "Shoop_1Cell.h"
#import "Shoop_2Cell.h"
#import "Shoop_3Cell.h"
#import "Shoop_4Cell.h"
#import "Index0_Cell.h"
@interface ShowViewController ()<ShowMoreItemsCellDelegate>

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            return 39;
            break;
        case 4:
            if (row==0) {
                return 33;
            }else{
             return 82;
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
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
         return cell;
    }else if(section==1){
        Shoop_1Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_1Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
         cell.delegate = self;
        return cell;
    }else if (section==3){
        Index0_Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (section==2){
        Shoop_2Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(section==4){
        if (row==0) {
            Shoop_3Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_3Cell" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
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

@end
