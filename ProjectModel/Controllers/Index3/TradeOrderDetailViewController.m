//
//  TradeOrderDetailViewController.m
//  Club
//
//  Created by dongway on 14-9-1.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "TradeOrderDetailViewController.h"
//#import "TradeOrderDetailCell.h"
#import "OrderDetailData.h"
#import <UIImageView+WebCache.h>
#import "MyOrderService.h"
#import "TradeDetailCell.h"
@interface TradeOrderDetailViewController ()<UIAlertViewDelegate>
{
    UserInfo *user;
    MyOrderService *myOrderService;
}
@end

@implementation TradeOrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
     myOrderService= [[MyOrderService alloc] init];
    [myOrderService goodsOrderDetailWithToken:user.token andUser_type:user.user_type andTabViewController:self.tabBarController andOrderid:self.orderid witdone:^(OrderDetailInfo *order){
        self.items=(NSMutableArray *)order.goods;
        self.redbag.text=[NSString stringWithFormat:@"扣除红包余额%0.2f",order.redbag];
        self.amount.text=[NSString stringWithFormat:@"扣除钱包余额%0.2f",order.amount];
        self.shipping.text=[NSString stringWithFormat:@"配送费%0.2f",order.shipping_fee];
        self.totals.text=[NSString stringWithFormat:@"扣除总额%0.2f",order.totals];
        if ([order.status isEqualToString:@"2"]) {
            self.cancel.hidden =NO;
        }else{
            self.cancel.hidden =YES;
        }
         self.tableViewHeight.constant=207*self.items.count;
        [self.tableView reloadData];
    }];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSInteger row = indexPath.row;
    OrderDetail *model = self.items[row];
    TradeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TradeDetailCell" forIndexPath:indexPath];
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]]placeholderImage:[UIImage imageNamed:@"e"]];
        cell.name.text = model.name;
        cell.numbs.text= [NSString stringWithFormat:@"数量:%@",model.num];
        cell.price.text = [NSString stringWithFormat:@"单价:%@",model.discount];
        cell.totalPrice.text = [NSString stringWithFormat:@"总价:%@",model.total];
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 207;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)deleate:(id)sender {
    [myOrderService goodsOrderReturnwithToken:user.token andUser_type:user.user_type andOrderid:self.orderid inTabbarViewController:self.tabBarController withDone:^(id model){
        UIAlertView *aletView = [[UIAlertView alloc]initWithTitle:@"退单成功" message:@"您已成功取消订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aletView show];
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
           [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    }
 
}
@end
