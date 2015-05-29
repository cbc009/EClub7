//
//  GoodTypeViewController.m
//  Club
//
//  Created by MartinLi on 15-4-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "GoodTypeViewController.h"
#import "BuyGoodTypeCell.h"
#import "BuyService.h"
#import "Goods_type.h"
#import <UIImageView+WebCache.h>
#import "GoodsViewController.h"
@interface GoodTypeViewController ()
{
    BuyService *buyService;
    UserInfo *user;
    UIView *naviBarView;

}

@end

@implementation GoodTypeViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:naviBarView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [naviBarView removeFromSuperview];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAgenTReload) name:@"AgentReload" object:nil];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    _tableView.showsVerticalScrollIndicator =NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    buyService =[BuyService new];
    [buyService loadGoodTypesWithAgent_Id:user.agent_id inViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNaviView{
    naviBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceFrame.size.width, 44)];
    naviBarView.backgroundColor=[UIColor redColor];
    
    UIButton *seach =[UIButton buttonWithType:UIButtonTypeCustom];
    seach.frame=CGRectMake(20, 8, 280, 28);
    [seach setBackgroundImage:[UIImage imageNamed:@"search(1)"] forState:UIControlStateNormal];
    [seach setBackgroundImage:[UIImage imageNamed:@"search(1)"] forState:UIControlStateHighlighted];
    [seach addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [naviBarView addSubview:seach];
}

-(void)search{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index4" bundle:nil];
    UIViewController *target = [storyboard instantiateViewControllerWithIdentifier:@"SerchViewController"];
    target.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:target animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodTypes.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyGoodTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyGoodTypeCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    Goods_type_goods_type *goods_type = self.goodTypes[row];
    NSArray *subtypes = goods_type.subtype;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,goods_type.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.firstType.text = goods_type.name;
    cell.firstType.textColor=[SharedAction colorWithHexString:goods_type.color];
    NSArray *arr=[self subtypeStringFromArray:subtypes];
    if (subtypes.count>=1) {
        cell.son1.text=arr[0];
        cell.son2.text=@"";
        cell.son3.text=@"";
        cell.son4.text=@"";
    }
    if (subtypes.count>=2){
        cell.son2.text=arr[1];
        cell.son3.text=@"";
        cell.son4.text=@"";
    }
    if (subtypes.count>=3){
         cell.son3.text=arr[2];
         cell.son4.text=@"";
    }
    if (subtypes.count>=4){
         cell.son4.text=arr[3];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    return 104;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        Goods_type_goods_type *goods_type = self.goodTypes[row];
        NSArray *subtypes = goods_type.subtype;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index4" bundle:nil];
        GoodsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GoodsViewController"];
        viewController.titletext=goods_type.name;
        viewController.subtypes = subtypes;
        viewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:viewController animated:YES];
    
}


/*
 二级目录的组合
 */
-(NSArray *)subtypeStringFromArray:(NSArray *)subtypes{
    NSMutableArray *subtypeArray = [NSMutableArray new];
    for (Goods_type_subType *subtype in subtypes) {
        if (subtype==subtypes.lastObject) {
            [subtypeArray addObject:subtype.name];
        }else{
            [subtypeArray addObject:subtype.name];;
        }
    }
    return subtypeArray;
}
-(void)changeAgenTReload{
    buyService =[BuyService new];
    [buyService loadGoodTypesWithAgent_Id:user.agent_id inViewController:self];
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
