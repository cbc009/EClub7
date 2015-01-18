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
@interface TradeOrderDetailViewController ()
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
    
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
     myOrderService= [[MyOrderService alloc] init];
    [myOrderService goodsOrderDetailWithToken:user.token andUser_type:user.user_type andTabViewController:self.tabBarController andOrderid:self.orderid witdone:^(OrderDetailInfo *order){
         OrderDetail *model = order.goods[0];
        [self.picture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        self.name.text = model.name;
        self.numbs.text= [NSString stringWithFormat:@"数量:%@",model.num];
        self.price.text = [NSString stringWithFormat:@"单价:%@",model.discount];
        self.totalPrice.text = [NSString stringWithFormat:@"总价:%@",model.total];
        if ([order.status isEqualToString:@"2"]) {
            self.cancel.hidden =NO;
        }else{
         self.cancel.hidden =YES;
        }
    }];
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
    
    }];
    
    
}
@end
