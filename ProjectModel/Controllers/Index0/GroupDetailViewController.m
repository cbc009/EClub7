//
//  GroupDetailViewController.m
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "GroupDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "GroupService.h"
#import "ItemDetailService.h"
#import "SharedAction.h"
#import "SVProgressHUD.h"
#import "WebViewController.h"
#import "GroupDetallCell.h"
#import "WebViewCell.h"
#import "Status.h"
@interface GroupDetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    GroupService *groupService;
    ItemDetailService *itemDetailService;
    NSTimer *timer;
    int countDownSeconds;
    NSString *gid;
    NSString *htmlStr;
    CGFloat height1;
    UserInfo *user;
}
@property (weak, nonatomic) IBOutlet UIButton *addGroupButton;
@end

@implementation GroupDetailViewController

-(void)loadView{
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData= [SharedData sharedInstance];
    user = sharedData.user;
    if (self.groupGood==nil) {
        self.title = self.historyGorupGood.name;
        gid = self.historyGorupGood.gid;
        self.numbs.text = @"1";
        [self.goodPicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.historyGorupGood.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        self.people.text = [NSString stringWithFormat:@"已参团人数%@",self.historyGorupGood.actual_num];
        self.price.text = [NSString stringWithFormat:@"%@元/%@",self.historyGorupGood.discount,self.historyGorupGood.unit];
        self.discount.text = [NSString stringWithFormat:@"会   员   价  :%@元/%@",self.historyGorupGood.price,self.historyGorupGood.unit];
        self.time.text = @"已结束";
         self.addGroupButton.hidden = YES;
        self.addBut.hidden=YES;
        self.reduceBut.hidden=YES;
        self.numbs.hidden=YES;
        self.numbes.hidden=YES;
        groupService = [[GroupService alloc] init];
        self.webview.scrollView.scrollEnabled = NO;
        [self loadWebPageWithString:[NSString stringWithFormat:GroupDetail,sharedData.user.token,sharedData.user.user_type,self.historyGorupGood.gid] inWebView:self.webview];
    }else{
    self.title = self.groupGood.name;
    gid = self.groupGood.gid;
    self.numbs.text = @"1";
    [self.goodPicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.groupGood.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    self.people.text = [NSString stringWithFormat:@"已参团人数%@",self.groupGood.actual_num];
    self.price.text = [NSString stringWithFormat:@"%@元/%@",self.groupGood.discount,self.groupGood.unit];
    self.discount.text = [NSString stringWithFormat:@"会   员   价  :%@元/%@",self.groupGood.price,self.groupGood.unit];
    groupService = [[GroupService alloc] init];
    itemDetailService = [[ItemDetailService alloc] init];
    countDownSeconds =self.groupGood.seconds;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
    self.webview.scrollView.scrollEnabled = NO;
    [self loadWebPageWithString:self.groupGood.url inWebView:self.webview];
    }
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
    [self.scrollview setContentSize:CGSizeMake(DeviceFrame.size.width, mWebViewTextSize.height+1)];
    self.webviewHeight.constant = mWebViewTextSize.height+50;
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request   navigationType:(UIWebViewNavigationType)navigationType {
//    return YES;
//}
#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
}
- (IBAction)shareAction:(id)sender {
    [SharedAction shareWithTitle:self.groupGood.name andDesinationUrl:AppDownLoadURL Text:@"在E小区中团购了我偶喜欢的宝贝好开心" andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.groupGood.bigpicture] InViewController:self];
}

#pragma UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==5) {
        if(buttonIndex==1){
            [SharedAction loginAggane];
            NSArray *viewControllers = self.navigationController.viewControllers;
            [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
        
        }
    }else if (alertView.tag==2) {
        if (buttonIndex==0) {
        }else if(buttonIndex == 1){
           
        }
    }else  if (alertView.tag==1) {
        if (buttonIndex==0) {
        }else if(buttonIndex == 1){
            [groupService presentCreatePayViewControllerOnViewController:self];
        }
    }else if (alertView.tag==4){
        NSString *password = [[alertView textFieldAtIndex:0] text]; 
        if (buttonIndex==0) {
         
        }else if(buttonIndex == 1){
            [groupService addToGroupWithPassword:password andToken:user.token andUser_type:user.user_type andGid:gid andNums:self.numbs.text inTabBarController:self.tabBarController withDoneObject:^(Status *model){
           
            }];
        }
    }else {
            NSString *password = [[alertView textFieldAtIndex:0] text];
            if (buttonIndex==0) {
        }else if(buttonIndex == 1){
            [groupService addToGroupWithPassword:password andToken:user.token andUser_type:user.user_type andGid:gid andNums:self.numbs.text inTabBarController:self.tabBarController withDoneObject:^(Status *model){
                
            }];
        }
    }
}

-(void)countDownTimer{
    if (countDownSeconds==0) {
        self.addGroupButton.enabled = NO;
        [timer invalidate];
    }else{
        countDownSeconds--;
        self.time.text = [groupService toDetailTime:countDownSeconds];
    }
}

- (IBAction)pay:(id)sender {
    if ([self.numbs.text isEqualToString:@"0"]){
        [SVProgressHUD showErrorWithStatus:@"购买数量不能为空"];
    }else{
       float price =[self.groupGood.discount floatValue]*[self.numbs.text floatValue];
        NSString *stringFloat = [NSString stringWithFormat:@"%0.2f",price];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付总额" message:[NSString stringWithFormat:@"%@元",stringFloat] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alertView show];
    }
}
- (IBAction)reduce:(id)sender {
    self.numbs.text = [itemDetailService reduceNumber:self.numbs];
}

- (IBAction)add:(id)sender {
    self.numbs.text = [itemDetailService addNumber:self.numbs];

}
@end
