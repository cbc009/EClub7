//
//  FinalConfirmViewController.m
//  Club
//
//  Created by dongway on 14-8-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "FinalConfirmViewController.h"
#import "ItemInfosCell.h"
#import "FinalConfirmService.h"
#import "GoodForSubmit.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "Delivery.h"
#import <BmobSDK/Bmob.h>
#import "Status.h"
#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "NSString+MT.h"

@interface FinalConfirmViewController ()
{
    __weak IBOutlet UITableView *tableview;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UILabel *totalPrice;
    __weak IBOutlet UIButton *submitButton;
    __weak IBOutlet UIView *userInfo;
    NSString *identifier;
    UserInfo *user;
    FinalConfirmService *finalConfirmService;
    __weak IBOutlet UILabel *amount;
    __weak IBOutlet UILabel *redbag;
    UIKeyboardViewController *keyBoardController;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1Height;

@end

@implementation FinalConfirmViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        finalConfirmService = [[FinalConfirmService alloc] init];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    identifier = @"ItemInfosCell";
    UINib *nib = [UINib nibWithNibName:@"ItemInfosCell" bundle:nil];
    [tableview registerNib:nib forCellReuseIdentifier:identifier];
    self.tableviewHeight.constant = (self.items.count+1)*34;
    self.view1Height.constant = self.tableviewHeight.constant+106;
    keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单确认";
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    totalPrice.text = [NSString stringWithFormat:@"总额:￥%@",self.totalPriceString];
    self.bottomTotalPrice.text = [NSString stringWithFormat:@"总额:￥%@",self.totalPriceString];
    amount.text = [NSString stringWithFormat:@"使用账户余额：￥%0.2f",user.amount];
    redbag.text = [NSString stringWithFormat:@"使用红包余额：￥%0.2f",user.amount_red];
    self.userPhone.text = user.mobile;
    self.sendAddress.text = user.address;
    [finalConfirmService loadDeliveryInfosWithToken:user.token anduser_type:user.user_type inTabBarController:self.tabBarController withDone:^(DeliveryInfo *model){
        self.timeArray = model.sendtime;
        self.delivery_scope.text = [NSString stringWithFormat:@"(%@)",model.delivery_scope];
        self.shipping_fee.text = [NSString stringWithFormat:@"%ld元",(long)model.shipping_fee];
        self.delivery_limit.text = [NSString stringWithFormat:@"小贴士:免费配送的最低交易金额为:￥%@元",model.delivery_limit];
        if (self.timeArray.count>0) {
            [self.sendTime setTitle:self.timeArray[0] forState:UIControlStateNormal];
        }else{
            [self.sendTime setTitle:@"暂不支持送货上门" forState:UIControlStateNormal];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    ItemInfosCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (row>0) {
        NSInteger index = row-1;
        GoodForSubmit *good = [self.items objectAtIndex:index];
        cell.name.text = good.name;
        cell.count.text = good.num;
        cell.singlePrice.text = [NSString stringWithFormat:@"￥%@/%@",good.discount,good.unit];
        cell.totalPrice.text = [NSString stringWithFormat:@"￥%0.1f",[good.discount floatValue]*[good.num integerValue]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    return 34;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma SelectedChildViewControllerDelegate
-(void)tableView:(UITableView *)tableView didSelectedCell:(UITableViewCell *)tableViewCell withController:(UIViewController *)viewController{
    [self.sendTime setTitle:tableViewCell.textLabel.text forState:UIControlStateNormal];
    [finalConfirmService hideChildController:viewController withObject:(id)self.sendTime];
    
}

#pragma - UIKeyboardViewController delegate methods
- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@", textView.text);
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
       if (alertView.tag==1) {
         if(buttonIndex==1){
    [finalConfirmService presentCreatePayViewControllerOnViewController:self];
         }
    }else if (alertView.tag==2) {
        if(buttonIndex==2){
        }
    }else if (alertView.tag==3) {
        if(buttonIndex==1){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }else if(alertView.tag==4){
        if(buttonIndex==1){
            [self payWithPassword:[[alertView textFieldAtIndex:0] text]];
        }
    }else {
       if(buttonIndex==1){
           [self payWithPassword:[[alertView textFieldAtIndex:0] text]];
        }
    }
}
-(void)payWithPassword:(NSString *)password{
    __block FinalConfirmViewController *blockSelf =self;
    NSString *datas = [NSString stringWithFormat:@"%@",[finalConfirmService finalItemsWithObjects:self.items]];
    NSString *payType = [finalConfirmService payTypeInViewController:self];
    NSString *sendType = [finalConfirmService sendTypeInViewController:self];
    NSString *Sendid = self.sendTime.titleLabel.text;
    NSString *address = self.sendAddress.text;
    NSString *mobile = self.userPhone.text;
    NSString *message = self.userMessage.text;
    NSString *paypassword = password;
    [finalConfirmService submitDatas:datas andToken:user.token andUser_type:user.user_type andPayType:payType sendType:sendType andSendid:Sendid andAddress:address andMobile:mobile andMessage:message withPassword:paypassword inTabBarController:self.tabBarController withDone:^(id object){
        NSNumber *stat = (NSNumber *)[object objectForKey:@"status"];
        NSInteger status2 = [stat integerValue];
        if (status2==806) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"密码错误" message:@"支付密码错误请重新输入" delegate:blockSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag=4;
            alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alertView show];
        }else{
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"购买成功" message:@"购买成功请及时到生活馆领取" delegate:blockSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag=3;
            [alertView show];
            BmobObject *model = [BmobObject objectWithClassName:@"BuyGoods"];
            [model setObject:user.loginname forKey:@"loginname"];
            [model setObject:datas forKey:@"info"];
            [model setObject:[NSNumber numberWithFloat:[blockSelf.bottomTotalPrice.text floatValue]] forKey:@"price"];
            [model saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            }];
        }
    }];
}

//选择送货时间
- (IBAction)selectTimeAction:(id)sender {
    [finalConfirmService showTimePickerViewOnView:scrollView withFrame:CGRectMake(userInfo.frame.origin.x+self.sendTime.frame.origin.x, self.thirdView.frame.origin.y + userInfo.frame.origin.y+self.sendTime.frame.origin.y, self.sendTime.frame.size.width,0) andDatas:self.timeArray onTarget:self withObject:(id)sender];
}

- (IBAction)submitAction:(id)sender {
    if (user.user_type==3) {
        [SVProgressHUD showErrorWithStatus:@"请前往 “我”页面中的“个人信息”“关联区域”完善资料"];
    }else{
    [self submitAction];
}
}
- (IBAction)payMethod1:(id)sender {
    [finalConfirmService payMethod1:sender inViewController:self];
}
- (IBAction)payMethod2:(id)sender {
    [finalConfirmService payMethod2:sender inViewController:self];
}
- (IBAction)sendMethod1:(id)sender {
    [finalConfirmService sendMethod1:sender inViewController:self];
}
- (IBAction)sendMethod2:(id)sender {
    [finalConfirmService sendMethod2:sender inViewController:self];
}


-(void)submitAction{
    if([finalConfirmService compareCurrentTimeWithTime:@"21:30:00"] == NSOrderedDescending && [finalConfirmService compareCurrentTimeWithTime:@"06:00:00"] == NSOrderedAscending){
        //如果是卖家送货
        if (self.sendMethod2.tag==1) {
            if ([self.sendAddress.text isEqualToString:@""]) {
                [SVProgressHUD showErrorWithStatus:@"请填写准确送货地址"];
                return;
            }else if(![self.userPhone.text isValidateMobile:self.userPhone.text]){
                [SVProgressHUD showErrorWithStatus:@"请正确填写手机号码"];
                return;
            }else if ([self.totalPriceString floatValue]<30){
                [SVProgressHUD showErrorWithStatus:@"不足30元消费，暂不提供送货上门服务"];
                return;
            }
        }
        SharedData *sharedData = [SharedData sharedInstance];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"支付密码" message:@"支付密码为登陆密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        if ([sharedData.fingerIsOpened isEqualToString:@"yes"]) {
            [SharedAction fingerPayWithDone:^(BOOL success,id object){
                if (success) {
                    [self payWithPassword:sharedData.payPassword];
                }else{
                    [alertView show];
                }
            }];
        }else{
            [alertView show];
        }
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"下单时间:每天6:00-21:30"];
    }
}


@end
