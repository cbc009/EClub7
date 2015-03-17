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
    self.title = self.goodModel.name;
    gid = self.goodModel.gid;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.goodModel.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
    self.currentPrice.text = [NSString stringWithFormat:@"%@元/%@",self.goodModel.discount,self.goodModel.unit];
    self.pastPrice.text = [NSString stringWithFormat:@"%@元/%@",self.goodModel.price,self.goodModel.unit];
    self.people.text = [NSString stringWithFormat:@"已购买人数%@",self.goodModel.nums];
    self.count.text = self.goodModel.unit_num;
    self.Ems.text = self.goodModel.logistics;
    self.floatButton = [MLFloatButton loadFromNibAddTarget :self InSuperView:self.view];
    self.webview.scrollView.scrollEnabled = NO;
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
    [self.scrollview setContentSize:CGSizeMake(DeviceFrame.size.width, mWebViewTextSize.height+100+250)];
     self.webviewHeight.constant = mWebViewTextSize.height;
}

//#pragma UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%@",NSStringFromCGSize(scrollView.contentSize));
//}

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
    self.count.text = [itemDetailService reduceNumber:self.count];
}

- (IBAction)addAction:(id)sender {
    self.count.text = [itemDetailService addNumber:self.count];
}

- (IBAction)buyAction:(id)sender {
   }

- (IBAction)addToPurchaseCar:(id)sender {
    NSString *num = self.count.text;
    [itemDetailService addToPurchaseCarWithGid:gid andNum:num inTabBarController:self.tabBarController withDone:^(Status *model){
    }];
}

- (IBAction)buynow:(id)sender {
    //立即购买
    NSString *count = self.count.text;
    [itemDetailService presentPurchaseCarViewControllerWithToken:user.token andUser_type:user.user_type andGid:self.goodModel.gid andNums:count inTabBarController:self.tabBarController withDone:^(Status *model){
          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index0" bundle:nil];
        PurchaseCarItemsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"PurchaseCarItemsViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
}
- (IBAction)share:(id)sender {
    [SharedAction shareWithTitle:self.title andDesinationUrl:self.goodModel.share_url Text:self.goodModel.name andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.goodModel.bigpicture] InViewController:self];
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    double alph = fabs(velocity.y);
//    NSLog(@"%f",alph);
//    if (alph<2.5) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        self.navigationController.navigationBar.alpha=alph*0.3;
//    }else {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        
//    }
//    
//    
//}
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;{
//    NSLog(@"hjhshs");
//}


@end
