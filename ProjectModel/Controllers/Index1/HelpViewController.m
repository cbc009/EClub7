//
//  HelpViewController.m
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

{
    __weak IBOutlet UIWebView *webview;
    UIActivityIndicatorView *activityIndicatorView;
}
@end
@implementation HelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    webview.delegate = self;
    self.title = @"打电话帮助";
    activityIndicatorView = [[UIActivityIndicatorView alloc] init];
   
    self.urlString = @"http://www.greenwh.com/wap.php/Phone/phone_help";
    [self loadWebPageWithString:self.urlString inWebView:webview];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    webview.hidden = YES;
    [self showActivityIndicatorView: activityIndicatorView inView:self.view];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
    webview.hidden = NO;
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
