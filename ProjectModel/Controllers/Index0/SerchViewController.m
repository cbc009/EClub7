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
#import "Member_Login.h"
#import "Type_goods.h"
#import "SKTag.h"
#import "SKTagButton.h"
#import "SKTagView.h"
#import <Masonry/Masonry.h>
#import <HexColors/HexColor.h>
#import "Search_label.h"
#import <QuartzCore/QuartzCore.h>
@interface SerchViewController ()<UISearchBarDelegate,UIScrollViewDelegate>
{
    SearchService *searchService;
    UserInfo *user;
    NSMutableArray  *labelArray;
    //标签是否出现  1为出现 0为不出现；
    int k;
}
@property (strong, nonatomic) SKTagView *tagView;
@property (nonatomic, strong) NSArray *colorPool;
@end

@implementation SerchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    k=0;
    self.title = @"商城搜索";
    labelArray = [NSMutableArray new];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
     searchService= [[SearchService alloc] init];
    self.tableview.hidden=YES;
    [searchService searchLabelwithToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(Search_Label_Info *object){
        for (int i=0; i<object.goods.count; i++) {
            Search_Goods_Info *model =object.goods[i];
            [labelArray addObject:model.name];
        }
        [self setupTagView];
    }];
    [self.search becomeFirstResponder];
     [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
{
    if (k==0) {
        NSLog(@"searchBarTextDidBeginEditing");
    }else{
        self.tableview.hidden=YES;
        [self setupTagView];
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
        NSLog(@"ddd");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.tagView removeFromSuperview];
//    searchBar.keyboardType = UIKeyboardTypeDefault;
    [searchService goodsSearchWithToken:user.token andUser_type:user.user_type anName:self.search.text inTabBarController:self.tabBarController withDoneObject:^(Type_goods_info *model){
        self.datas =(NSArray *)model;
        [self.tableview reloadData];
        self.tableview.hidden=NO;
    }];
    k=1;
    [searchBar resignFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
      [SVProgressHUD dismiss];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.search resignFirstResponder];
}


- (void)setupTagView
{
    SKTagView *view;
    self.tagView = ({
        view = [SKTagView new];
        view.backgroundColor = [UIColor clearColor];
        view.padding    = UIEdgeInsetsMake(16, 12, 6, 6);
        view.insets    = 8;
        view.lineSpace = 10;
        view;
    });
    [self.view addSubview:self.tagView];
    [labelArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SKTag *tag = [SKTag tagWithText:obj];
         tag.textColor = UIColor.grayColor;
         tag.bgColor = UIColor.whiteColor;
         tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
         tag.target = self;
         tag.action = @selector(handleBtn:);
         tag.cornerRadius = 2;
        [self.tagView addTag:tag];
    }];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = self.view;
        make.centerY.equalTo(superView.mas_top).centerY.offset(NavigationBarFrame.size.height+StatusBarFrame.size.height+120);
        make.leading.equalTo(superView.mas_leading).with.offset(0);
        make.trailing.equalTo(superView.mas_trailing);
    }];

}
- (void)handleBtn:(SKTagButton *)btn
{
    self.search.text = btn.mTag.text;
    [searchService goodsSearchWithToken:user.token andUser_type:user.user_type anName:self.search.text inTabBarController:self.tabBarController withDoneObject:^(Type_goods_info *model){
        self.datas =(NSArray *)model;
        [self.tableview reloadData];
        self.tableview.hidden=NO;
        k=1;
        [self.search resignFirstResponder];
        [self.tagView removeFromSuperview];
    }];
}
@end
