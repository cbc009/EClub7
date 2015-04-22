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
}

@end

@implementation GoodTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    self.title=@"商城";
    buyService =[BuyService new];
    [buyService loadGoodTypesWithToken:user.token andUser_type:user.user_type InViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.secondType.text = [self subtypeStringFromArray:subtypes];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    return 109;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        Goods_type_goods_type *goods_type = self.goodTypes[row];
        NSArray *subtypes = goods_type.subtype;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        GoodsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"GoodsViewController"];
        viewController.titletext=goods_type.name;
        viewController.subtypes = subtypes;
        viewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:viewController animated:YES];
    
}


/*
 二级目录的组合
 */
-(NSString *)subtypeStringFromArray:(NSArray *)subtypes{
    NSMutableString *subtypeString = [[NSMutableString alloc] initWithString:@""];
    for (Goods_type_subType *subtype in subtypes) {
        if (subtype==subtypes.lastObject) {
            [subtypeString appendString:[NSString stringWithFormat:@"%@",subtype.name]];
        }else{
            [subtypeString appendString:[NSString stringWithFormat:@"%@/",subtype.name]];
        }
    }
    return subtypeString;
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
