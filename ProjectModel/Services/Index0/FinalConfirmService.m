//
//  FinalConfirmService.m
//  Club
//
//  Created by dongway on 14-8-13.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "FinalConfirmService.h"
#import "FinalConfirmViewController.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "GoodForSubmit.h"
#import "MyMD5.h"
#import "JSONModelLib.h"
#import "Status.h"
#import "SVProgressHUD.h"
#import "NSString+MT.h"
#import "Delivery.h"
#import "SharedAction.h"
#import <BmobSDK/Bmob.h>
@implementation FinalConfirmService

//显示pickerview
-(void)showTimePickerViewOnView:(UIView *)superView withFrame:(CGRect)frame andDatas:(NSArray *)datas onTarget:(id<SelectedItemsTableViewControllerDelegate>)delegate withObject:(id)sender{
    FinalConfirmViewController *selfController = (FinalConfirmViewController *)delegate;
    UIButton *button = (UIButton *)sender;
    SelectItemsTableViewController *viewController = [[SelectItemsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    viewController.view.frame = frame;
    viewController.datas =(NSMutableArray *)datas;
    viewController.delegate = selfController;
    [selfController addChildViewController:viewController];
    [superView addSubview:viewController.view];
    button.enabled = NO;
    float height = 44*datas.count;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = viewController.view.frame;
        if (frame.size.height<height) {
            frame = CGRectMake(frame.origin.x, frame.origin.y-height, frame.size.width, frame.size.height+height);
            viewController.view.frame = frame;
        }
    }];
}

//隐藏pickerview
-(void)hideChildController:(UIViewController *)childController withObject:(id)object{
    SelectItemsTableViewController *viewController = (SelectItemsTableViewController *)childController;
    NSInteger count = viewController.datas.count;
    float height = (-44*count);
    UIButton *button = (UIButton *)object;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = childController.view.frame;
        frame = CGRectMake(frame.origin.x, frame.origin.y-height, frame.size.width, frame.size.height+height);
        childController.view.frame = frame;
    } completion:^(BOOL finished){
        [childController removeFromParentViewController];
        button.enabled = YES;
    }];
}

-(void)payMethod1:(UIButton *)sender inViewController:(FinalConfirmViewController *)viewController{
    viewController.payMethod1.tag = 1;
    viewController.payMethod2.tag = -1;
    [viewController.payMethod1 setImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
    [viewController.payMethod2 setImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];

}

-(void)payMethod2:(UIButton *)sender inViewController:(FinalConfirmViewController *)viewController{
    viewController.payMethod1.tag = -1;
    viewController.payMethod2.tag = 1;
    [viewController.payMethod1 setImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
    [viewController.payMethod2 setImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];

}

-(void)sendMethod1:(UIButton *)sender inViewController:(FinalConfirmViewController *)viewController{
    viewController.sendMethod1.tag = 1;
    viewController.sendMethod2.tag = -1;
    [viewController.sendMethod1 setImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
    [viewController.sendMethod2 setImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
    viewController.bottomTotalPrice.text = [NSString stringWithFormat:@"总额:￥%0.1f",[viewController.totalPriceString floatValue]];

}

-(void)sendMethod2:(UIButton *)sender inViewController:(FinalConfirmViewController *)viewController{
    viewController.sendMethod1.tag = -1;
    viewController.sendMethod2.tag = 1;
    [viewController.sendMethod1 setImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
    [viewController.sendMethod2 setImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
    viewController.bottomTotalPrice.text = [NSString stringWithFormat:@"总额:￥%0.1f",[viewController.totalPriceString floatValue]+[[viewController.shipping_fee.text substringToIndex:viewController.shipping_fee.text.length-1] floatValue]];

}
-(void)submitActionInViewController:(FinalConfirmViewController *)viewController{
    
    
    if([self compareCurrentTimeWithTime:@"21:30:00"] == NSOrderedDescending && [self compareCurrentTimeWithTime:@"06:00:00"] == NSOrderedAscending){
        //如果是卖家送货
        if (viewController.sendMethod2.tag==1) {
            if ([viewController.sendAddress.text isEqualToString:@""]) {
                [SVProgressHUD showErrorWithStatus:@"请填写准确送货地址"];
                return;
            }else if(![viewController.userPhone.text isValidateMobile:viewController.userPhone.text]){
                [SVProgressHUD showErrorWithStatus:@"请正确填写手机号码"];
                return;
            }else if ([viewController.totalPriceString floatValue]<30){
                [SVProgressHUD showErrorWithStatus:@"不足30元消费，暂不提供送货上门服务"];
                return;
            }
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付密码" message:@"支付密码为登陆密码" delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alertView show];

    }else{
        [SVProgressHUD showErrorWithStatus:@"下单时间:每天6:00-21:30"];
    }
}

//比较时间，timeString格式为HH:mm:ss
-(NSComparisonResult)compareCurrentTimeWithTime:(NSString *)timeString{
    NSDate *currenTime = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTimeString = [formatter stringFromDate:currenTime];
    timeString = [currentTimeString stringByReplacingCharactersInRange:NSMakeRange(11, 8) withString:timeString];
    NSDate *time = [formatter dateFromString:timeString];
    return [time compare:currenTime];
}

-(void)submitInViewController:(FinalConfirmViewController *)viewController withPassword:(NSString *)password{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *user_type =[NSString stringWithFormat:@"%ld",(long)user.user_type];
    NSString *datas = [NSString stringWithFormat:@"%@",[self finalItemsWithObjects:viewController.items]];
    NSString *payType = [self payTypeInViewController:viewController];
    NSString *sendType = [self sendTypeInViewController:viewController];
    NSString *Sendid = viewController.sendTime.titleLabel.text;
    NSString *address = viewController.sendAddress.text;
    NSString *mobile = viewController.userPhone.text;
    NSString *message = viewController.userMessage.text;
    NSString *passwd = [MyMD5 md5:password];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:user.token, @"token",user_type,@"user_type",datas,@"info",payType,@"paymenttype",sendType,@"sendtype",Sendid,@"sendtime",passwd,@"paypassword",address,@"address",mobile,@"mobile",message    ,@"message",nil];
    [SVProgressHUD show];
    [JSONHTTPClient postJSONFromURLWithString:SubmitItemsURL params:dict completion:^(id object, JSONModelError *err) {
        NSNumber *status1 = (NSNumber *)[object objectForKey:@"status"];
        NSString *error1= (NSString *)[object objectForKey:@"error"];
        NSInteger status = [status1 integerValue];
        if (status==2) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"购买成功" message:@"请到小区所在生活馆及时提取物品" delegate:viewController cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            if ([payType isEqualToString:@"2"]) {
                user.amount = user.amount -[viewController.totalPriceString floatValue];
            }else if ([viewController.totalPriceString floatValue]>user.amount_red) {
                    user.amount_red = 0;
                    user.amount = user.amount-([viewController.totalPriceString floatValue] -user.amount_red);
                }else{
                user.amount_red = user.amount_red - [viewController.totalPriceString floatValue];
            }
            alertView.tag=3;
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            [alertView show];
            [SVProgressHUD dismiss];
            
            //存储到Bmob后台
            BmobObject *model = [BmobObject objectWithClassName:@"BuyGoods"];
            [model setObject:user.loginname forKey:@"loginname"];
            [model setObject:datas forKey:@"info"];
            [model setObject:[NSNumber numberWithFloat:[viewController.bottomTotalPrice.text floatValue]] forKey:@"price"];
            [model saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                //进行操作
            }];
        } else {
            [SharedAction showErrorWithStatus:status andError:error1 witViewController:viewController];
        }
    }];
    
}
//跳到充值页面
-(void)presentCreatePayViewControllerOnViewController:(UIViewController *)viewController{
    NSLog(@"dd");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    CreatePayViewController *createPayViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreatePayViewController"];
    [viewController.navigationController pushViewController:createPayViewController animated:YES];
       
}


-(NSString *)finalItemsWithObjects:(NSArray *)datas{
    NSMutableString *items = [[NSMutableString alloc] init];
    NSInteger count = datas.count;
    for (NSInteger i=0; i<count; i++) {
        GoodForSubmit *good = [datas objectAtIndex:i];
        if (i==count-1) {
            [items appendString:[NSString stringWithFormat:@"%@:%@",good.gid,good.num]];
        }else{
            [items appendString:[NSString stringWithFormat:@"%@:%@,",good.gid,good.num]];
        }
    }
    return items;
}

-(NSString *)payTypeInViewController:(FinalConfirmViewController *)viewController{
    NSString *payType;
    if(viewController.payMethod2.tag==1){
        payType = @"1";
    }else{
        payType = @"2";
    }
    return payType;
}

//送货方式
-(NSString *)sendTypeInViewController:(FinalConfirmViewController *)viewController{
    NSString *sendType;
    if (viewController.sendMethod1.tag==1) {
        sendType=@"1";
    }else if(viewController.sendMethod2.tag==1){
        sendType = @"2";
    }
    return sendType;
}


-(void)loadDeliveryInfosWithToken:(NSString *)token anduser_type:(NSInteger)user_type inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:DeliveryURL,token,user_type];
    [SVProgressHUD show];
    [Delivery getModelFromURLWithString:urlString completion:^(Delivery *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
@end



