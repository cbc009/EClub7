//
//  PointGoodViewController.m
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "PointGoodViewController.h"


#import "PointGoodViewControllerService.h"
@interface PointGoodViewController ()
{
    NSInteger sum;
    PointGoodViewControllerService *pointGoodViewControllerService;
}
@end

@implementation PointGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品兑换详情";
    pointGoodViewControllerService = [[PointGoodViewControllerService alloc] init];
    
    [pointGoodViewControllerService LoadDataInPointGoodViewController:self];
    sum = 1;
    self.num.text = [NSString stringWithFormat:@"%ld",(long)sum];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *password = [[alertView textFieldAtIndex:0] text];
    if (buttonIndex==0) {
        
    }else if(buttonIndex == 1){
        [pointGoodViewControllerService addOderInPointGoodViewController:self WithPassword:password AndSum:sum];
    }
}

- (IBAction)Add:(id)sender {
    sum ++;
    self.num.text = [NSString stringWithFormat:@"%ld",(long)sum];
    
}

- (IBAction)Releas:(id)sender {
    if (sum<1) {
        sum = 0;
    }else {
    sum --;
    self.num.text = [NSString stringWithFormat:@"%ld",(long)sum];
    }
}

- (IBAction)addGood:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付密码" message:@"支付密码默认为登陆密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alertView show];
}
@end
