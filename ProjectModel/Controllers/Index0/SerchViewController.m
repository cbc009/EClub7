//
//  SerchViewController.m
//  Club
//
//  Created by MartinLi on 14-12-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "SerchViewController.h"
#import "Goods_type.h"
#import "ItemCell.h"
#import <UIImageView+WebCache.h>
#import "Type_goods.h"
#import "Search_goods.h"
#import "ItemDetailViewController.h"
#import "PurchaseCarItemsViewController.h"
#import "SearchService.h"
#import "SharedData.h"
#import "Login.h"
#import "Type_goods.h"
@interface SerchViewController ()<UISearchBarDelegate>
@end

@implementation SerchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商城搜索";
     [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
 }
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
{
    NSLog(@"11111dddd");

}

-(void)viewDidDisappear:(BOOL)animated{
 [super viewWillAppear:animated];
[self.search resignFirstResponder];

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                  
{
    SearchService *searchService = [[SearchService alloc] init];
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    searchBar.keyboardType = UIKeyboardTypeDefault;
    [searchService goodsSearchWithToken:user.token andUser_type:user.user_type anName:self.search.text withDoneObject:^(Type_goods_info *model){
        self.datas =(NSArray *)model;
        [self.tableview reloadData];
    }];
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goodToDetail"]) {
        NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
        NSInteger row = indexPath.row;
         Type_goods_good *good =[[Type_goods_good alloc] initWithDictionary:self.datas[row] error:nil];
        ItemDetailViewController *viewController = segue.destinationViewController;
        viewController.goodModel = good;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    Type_goods_good *model =[[Type_goods_good alloc] initWithDictionary:self.datas[row] error:nil];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.pastPrice.text = [NSString stringWithFormat:@"原价:%@元/%@",model.price,model.unit];
    cell.currenPrice.text = [NSString stringWithFormat:@"%@元/%@",model.discount,model.unit];
    cell.discout.text = [NSString stringWithFormat:@"%0.1f折",[model.discount floatValue]/[model.price floatValue]];
    if (model.goods_new == 2) {
        cell.goodimage.image= [UIImage imageNamed:@"shop_new_tag3"];
    }else if(model.goods_new == 3){
        cell.goodimage.image= [UIImage imageNamed:@"special_selling"];
    }else if(model.goods_new == 1){
        [cell.goodimage highlightedImage];
    }

    cell.name.text = model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
