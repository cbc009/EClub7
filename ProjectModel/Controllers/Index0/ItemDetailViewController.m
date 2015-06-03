//
//  ItemDetailViewController.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

//
//  ItemDetailViewController.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ItemDetailService.h"
#import <UIImageView+WebCache.h>
#import "PurchaseCarItemsViewController.h"
#import "WebViewController.h"
#import "MLFloatButton.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "SVProgressHUD.h"
#import "Status.h"
@interface ItemDetailViewController ()<MLFloatButtonDelegate,UIWebViewDelegate,UIScrollViewDelegate>
{
    ItemDetailService *itemDetailService;
    WebViewController *target;
    UserInfo *user;
    NSString *gid;
}
@end

@implementation ItemDetailViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        itemDetailService = [[ItemDetailService alloc] init];
    }
    return self;
}
-(void)loadView{
    [super loadView];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollview setContentOffset:CGPointMake(15, 0)];
//    self.title = self.goodModel.name;
    gid = self.goodModel.gid;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.goodModel.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
    self.currentPrice.text = [NSString stringWithFormat:@"%@元/%@",self.goodModel.discount,self.goodModel.unit];
    self.pastPrice.text = [NSString stringWithFormat:@"%@元/%@",self.goodModel.price,self.goodModel.unit];
    
    self.reduce.layer.cornerRadius=2;
    self.reduce.layer.borderWidth=1;
    self.reduce.layer.borderColor=[UIColor redColor].CGColor;
    
    self.add.layer.cornerRadius=2;
    self.add.layer.borderWidth=1;
    self.add.layer.borderColor=[UIColor redColor].CGColor ;
    self.recveAddress.text=user.lifehall_address;
    self.shoopAddress.text=user.lifehall_name;
    self.count.layer.borderWidth=1;
    self.count.layer.borderColor=[UIColor redColor].CGColor;
    
    self.goodName.text=self.goodModel.name;
    self.people.text = [NSString stringWithFormat:@"%@人已购买",self.goodModel.nums];
    self.count.text = self.goodModel.unit_num;
    self.Ems.text = self.goodModel.logistics;
    self.floatButton = [MLFloatButton loadFromNibAddTarget :self InSuperView:self.view];
    self.webview.scrollView.scrollEnabled = NO;
    self.count.text=self.goodModel.unit_num;
    [self loadWebPageWithString:self.goodModel.url inWebView:self.webview];
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
    self.webview.frame = frame;
    self.webviewHeight.constant = mWebViewTextSize.height;
    [self.scrollview setContentSize:CGSizeMake(DeviceFrame.size.width, mWebViewTextSize.height+442)];
}

-(void)buttonTouchAction
{
    PurchaseCarItemsViewController *purchaseCar = [self.storyboard instantiateViewControllerWithIdentifier:@"PurchaseCarItemsViewController"];
    [self.navigationController pushViewController:purchaseCar animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reduceAction:(id)sender {
    if ([self.count.text integerValue]<=[self.goodModel.unit_num integerValue]){
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"当前商品不能购买低于%@ %@",self.goodModel.unit_num,self.goodModel.unit]];
    }else{
        self.count.text=[SharedAction reduceNumber:self.count];
    }
}

- (IBAction)addAction:(id)sender {
    self.count.text = [SharedAction addNumber:self.count];
}

- (IBAction)buyAction:(id)sender {
   
}

- (IBAction)addToPurchaseCar:(id)sender {
    if (user.user_type!=2) {
        UIAlertView *aletview=[[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"由于您还没有登录，为了抢到您心仪的宝贝建议您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定登录", nil];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        aletview.tag=5;
        [aletview show];
        return;
    }
    NSString *num = self.count.text;
    [itemDetailService addToPurchaseCarWithGid:gid andNum:num inTabBarController:self.tabBarController withDone:^(Status *model){
    }];
}

- (IBAction)buynow:(id)sender {
    if (user.user_type!=2) {
        UIAlertView *aletview=[[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"由于您还没有登录，为了抢到您心仪的宝贝建议您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定登录", nil];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        aletview.tag=5;
        [aletview show];
        return;
    }
    //立即购买
    NSString *count = self.count.text;
    [itemDetailService presentPurchaseCarViewControllerWithToken:user.token andUser_type:user.user_type andGid:self.goodModel.gid andNums:count inTabBarController:self.tabBarController withDone:^(Status *model){
          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index4" bundle:nil];
        PurchaseCarItemsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"PurchaseCarItemsViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
}
- (IBAction)share:(id)sender {
    [SharedAction shareWithTitle:self.title andDesinationUrl:self.goodModel.share_url Text:self.goodModel.name andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.goodModel.bigpicture] InViewController:self];
}

#pragma UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==5){
        if(buttonIndex==1){
            [self.tabBarController.selectedViewController beginAppearanceTransition: YES animated:YES];
            self.tabBarController.selectedIndex=0;
            UINavigationController *nav = self.tabBarController.viewControllers[self.tabBarController.selectedIndex];
            [nav popToRootViewControllerAnimated:YES];
            [SharedAction presentLoginViewControllerInViewController:nav];
        }
    }
}


@end
