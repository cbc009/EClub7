//
//  ShoopGoodsViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShoopGoodsViewController.h"
#import "CheckedViewController.h"
#import <UIImageView+WebCache.h>
@interface ShoopGoodsViewController ()<UIWebViewDelegate>
{
    UserInfo *user;
}
@end

@implementation ShoopGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    self.title=self.models.goods_name;
    self.reduce.layer.cornerRadius=2;
    self.reduce.layer.borderWidth=1;
    self.reduce.layer.borderColor=[UIColor redColor].CGColor;
  
    self.add.layer.cornerRadius=2;
    self.add.layer.borderWidth=1;
    self.add.layer.borderColor=[UIColor redColor].CGColor;
    
//    self.numbs.layer.cornerRadius=2;
    self.numbs.layer.borderWidth=1;
    self.numbs.layer.borderColor=[UIColor redColor].CGColor;
    self.numbs.text=@"1";
    self.buyNow.layer.cornerRadius=4;
//    self.scrollView.autoresizesSubviews=YES;
    [self loadWebPageWithString:[NSString stringWithFormat:Robuy_Goods_Detail_URL,self.models.goods_id] inWebView:self.webView];
    [self setValue];
}


- (void)loadWebPageWithString:(NSString*)urlString inWebView:(UIWebView *)webView{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
    CGRect frame = webView.frame;
    CGSize mWebViewTextSize = [webView sizeThatFits:CGSizeMake(1.0f, 1.0f)];
    frame.size = mWebViewTextSize;
    self.webView.frame = frame;
    self.myWebViewHeight.constant = mWebViewTextSize.height;
    [self.scrollView setContentSize:CGSizeMake(DeviceFrame.size.width, mWebViewTextSize.height+442)];
    NSLog(@"%f",self.scrollView.frame.size.height);
}
-(void)setValue{
    [self.bigPicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.models.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
    self.goodName.text=self.models.goods_name;
    self.price.text=self.models.price;
    self.vipPrice.text=self.models.discount;
    self.address.text=self.models.receive_address;
    self.workTime.text =[NSString stringWithFormat:@"%@-%@",self.models.send_time[0],self.models.send_time[1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addnumbs:(id)sender {
    self.numbs.text=[SharedAction addNumber:self.numbs];
}

- (IBAction)reduceNumbs:(id)sender {
    self.numbs.text=[SharedAction reduceNumber:self.numbs];
}

- (IBAction)share:(id)sender {
    NSString *share_url=[NSString stringWithFormat:Seller_Seller_Goods_Share_URL,self.models.goods_id];
     [SharedAction shareWithTitle:self.title andDesinationUrl:share_url Text:self.models.goods_name andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.models.bigpicture] InViewController:self];
}

- (IBAction)buyNow:(id)sender {
    if (user.user_type!=2) {
        UIAlertView *aletview=[[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"由于您还没有登录，为了买到您心仪的宝贝建议您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定登录", nil];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        aletview.tag=5;
        [aletview show];
        return;
    }

    if ([self.numbs.text isEqualToString:@"0"]) {
        [SVProgressHUD showErrorWithStatus:@"购买数量不能为0！"];
        return;
    }
    UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    CheckedViewController *checkedViewController=[storyBoard instantiateViewControllerWithIdentifier:@"CheckedViewController"];
    checkedViewController.models=self.models;
    checkedViewController.numbs=self.numbs.text;
    [self.navigationController pushViewController:checkedViewController animated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
            [self.tabBarController.selectedViewController beginAppearanceTransition: YES animated:YES];
            self.tabBarController.selectedIndex=0;
            UINavigationController *nav = self.tabBarController.viewControllers[self.tabBarController.selectedIndex];
            [nav popToRootViewControllerAnimated:YES];
            [SharedAction presentLoginViewControllerInViewController:nav];
    }
}
@end
