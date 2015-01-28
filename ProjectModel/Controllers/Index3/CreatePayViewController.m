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
#import "Member_Login.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlixPayOrder.h"
#import "Create_pay_order.h"
#import "SVProgressHUD.h"
#import "UPay_Order.h"
#import "UPPayViewController.h"

@interface CreatePayViewController ()
{
    UPPayViewController *uppayViewController;
    CreatePayService *service;
    NSInteger payType;
}
@property(nonatomic,strong)Create_pay_orderInfo *info;
@end

@implementation CreatePayViewController


-(void)viewWillAppear:(BOOL)animated
{
    [uppayViewController.view removeFromSuperview];
    [uppayViewController removeFromParentViewController];
    [super viewWillAppear:animated];
     payType = ailpayType;
    [self.ali setBackgroundImage:[UIImage imageNamed:@"checked_true.png"] forState:UIControlStateNormal];
    [self.upaypay setBackgroundImage:[UIImage imageNamed:@"checked_false.png"] forState:UIControlStateNormal];
    [self.weipaypay setBackgroundImage:[UIImage imageNamed:@"checked_false.png"] forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"在线充值";
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
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
    if (user.user_type==3) {
         [SVProgressHUD showErrorWithStatus:@"请前往 “我”页面中的“个人信息”“关联区域”完善资料"];
    }else{
    if (payType==ailpayType) {
        [service create_orderWithToken:user.token andUserType:user.user_type andPrice:self.price.text andPayModel:@"PAY_BAO" inTabBarController:self.tabBarController withDone:^(Create_pay_orderInfo *model){
            NSString *appScheme = @"Club";
            NSString* orderInfo = [self getOrderInfoWithCreate_pay_orderInfo:model andPrice:self.price.text];
            NSString* signedStr = [self doRsa:orderInfo andPrivateKey:model.private];
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                     orderInfo, signedStr, @"RSA"];
            sharedData.createPayPrice = [self.price.text floatValue];
            NSLog(@"sharedData.createPayPrice:%f",sharedData.createPayPrice);
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                //            NSLog(@"reslut = %@",resultDic);
                //            NSString *status = [resultDic objectForKey:@"resultStatus"];
                //            if ([status isEqualToString:@"9000"]) {
                //                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                //                user.amount = user.amount+[self.price.text floatValue];
                //                [service pushToMyWalletViewControllerInTabBarController:self.tabBarController];
                ////                [service reloadAmoutAfterPopToViewControllerInNav:self.navigationController];
                //            }else{
                //                [SVProgressHUD showErrorWithStatus:@"支付失败"];
                //            }
            }];
        }];
    }else if(payType==UPPayType){
        NSLog(@"银联支付");
        [service create_orderWithToken:user.token andUserType:user.user_type andPrice:self.price.text andPayModel:@"PAY_UNION" inTabBarController:self.tabBarController withDone:^(UPay_Order_info *model){
            
            uppayViewController= [[UPPayViewController alloc] init];
            uppayViewController.tn=model.tn;
            sharedData.createPayPrice = [self.price.text floatValue];
            NSLog(@"%@",uppayViewController.tn);
            [self addChildViewController:uppayViewController];
            [self.view addSubview:uppayViewController.view];
        }];
    }else{
        NSLog(@"微信支付");

        [SVProgressHUD showErrorWithStatus:@"暂未开通微信支付，敬请期待！"];
    }
    }
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



- (IBAction)alipay:(id)sender {
    payType=ailpayType;
    [self.ali setBackgroundImage:[UIImage imageNamed:@"checked_true.png"] forState:UIControlStateNormal];
    [self.upaypay setBackgroundImage:[UIImage imageNamed:@"checked_false.png"] forState:UIControlStateNormal];
    [self.weipaypay setBackgroundImage:[UIImage imageNamed:@"checked_false.png"] forState:UIControlStateNormal];
}

- (IBAction)uppay:(id)sender {
    payType=UPPayType;
    [self.ali setBackgroundImage:[UIImage imageNamed:@"checked_false.png"] forState:UIControlStateNormal];
    [self.upaypay setBackgroundImage:[UIImage imageNamed:@"checked_true.png"] forState:UIControlStateNormal];
    [self.weipaypay setBackgroundImage:[UIImage imageNamed:@"checked_false.png"] forState:UIControlStateNormal];
}

- (IBAction)weipay:(id)sender {
    payType=WeiPayType;
    [self.ali setBackgroundImage:[UIImage imageNamed:@"checked_false.png"] forState:UIControlStateNormal];
    [self.upaypay setBackgroundImage:[UIImage imageNamed:@"checked_false.png"] forState:UIControlStateNormal];
    [self.weipaypay setBackgroundImage:[UIImage imageNamed:@"checked_true.png"] forState:UIControlStateNormal];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
//    [self.view removeGestureRecognizer:tap];
    [self.price resignFirstResponder];
}
@end
