//
//  WebViewController.m
//  Club
//
//  Created by dongway on 14-8-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "WebViewController.h"
#import "SVProgressHUD.h"

@interface WebViewController ()
{
    //    __weak IBOutlet UIWebView *webview;
    UIActivityIndicatorView *activityIndicatorView;
}
@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{
    [super loadView];
    _webview.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    if (self.loadType==1) {
        [_webview loadHTMLString:self.htmlString baseURL:nil];
    }else{
    [self loadWebPageWithString:self.urlString inWebView:_webview];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _webview.hidden = YES;
    // 由于contentsize是326 所以让contensize与scrollview的宽度相等
    _webview.scrollView.contentSize =_webview.scrollView.frame.size;
    [self showActivityIndicatorView: activityIndicatorView inView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
 
    _webview.hidden = NO;
    _webview.frame=CGRectMake(0,0,DeviceFrame.size.width, DeviceFrame.size.height);

}

- (void)loadWebPageWithString:(NSString*)urlString inWebView:(UIWebView *)webView{
    NSURL *url =[NSURL URLWithString:urlString];
    NSLog(@"%@",urlString);
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

-(void)showActivityIndicatorView:(UIActivityIndicatorView *)activityView inView:(UIView *)view{
    
    [activityView stopAnimating];
    CGSize size = CGSizeMake(40, 40);
    [activityView setFrame:CGRectMake((DeviceFrame.size.width-size.width)/2, (DeviceFrame.size.height-size.height)/2, size.width, size.height)];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [activityView hidesWhenStopped];
    activityView.color = [UIColor blackColor];
    [activityView startAnimating];
    [view addSubview:activityView];
}

@end







