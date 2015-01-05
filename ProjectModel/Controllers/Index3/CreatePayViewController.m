//
//  CreatePayViewController.m
//  Club
//
//  Created by Gao Huang on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "CreatePayViewController.h"
#import "CreatePayService.h"
#import "SharedData.h"
#import "Login.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlixPayOrder.h"
#import "Create_pay_order.h"
#import "SVProgressHUD.h"

@interface CreatePayViewController ()
{
    CreatePayService *service;
}
@property(nonatomic,strong)Create_pay_orderInfo *info;
@end

@implementation CreatePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"在线充值";
    service = [[CreatePayService alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)recharge1:(id)sender {
    self.price.text = @"50";
}
- (IBAction)recharge2:(id)sender {
    self.price.text = @"100";
}
- (IBAction)recharge3:(id)sender {
    self.price.text = @"200";
}
- (IBAction)recharge4:(id)sender {
    self.price.text = @"500";
}
- (IBAction)rechargeAction:(id)sender {
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    [service loadCreatePayOrderInfoWithMid:user.mid andPrice:self.price.text finished:^(Create_pay_orderInfo *model){
        NSString *appScheme = @"Club";
        NSString* orderInfo = [self getOrderInfoWithCreate_pay_orderInfo:model andPrice:self.price.text];
        NSString* signedStr = [self doRsa:orderInfo andPrivateKey:model.private];
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                 orderInfo, signedStr, @"RSA"];
        //    NSLog(@"%@",orderString);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSString *status = [resultDic objectForKey:@"resultStatus"];
            if ([status isEqualToString:@"9000"]) {
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                [service reloadAmoutAfterPopToViewControllerInNav:self.navigationController];
            }else{
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
            }
        }];
    }];
}

-(NSString*)getOrderInfoWithCreate_pay_orderInfo:(Create_pay_orderInfo *)model andPrice:(NSString *)price
{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = model.default_partner;
    order.seller = model.default_seller;
    order.tradeNO = model.out_trade_no; //订单ID（由商家自行制定）
    order.productName = [NSString stringWithFormat:@"%@在线充值",user.nickname]; //商品标题
    order.productDescription = @"E小区充值"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[price floatValue]]; //商品价格
    order.notifyURL = model.notify_url; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    return [order description];
}

-(NSString*)doRsa:(NSString*)orderInfo andPrivateKey:(NSString *)privateKey
{
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

@end
