//
//  WebCell.m
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "WebCell.h"

@implementation WebCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    [self loadWebPageWithString:[NSString stringWithFormat:Robuy_Goods_Detail_URL,self.robGoodsid] inWebView:self.webView];
//    self.webView.delegate = self;
//    self.webView.scrollView.scrollEnabled = NO;
    // Configure the view for the selected state
}

//- (void)loadWebPageWithString:(NSString*)urlString inWebView:(UIWebView *)webView{
//    NSURL *url =[NSURL URLWithString:urlString];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
//}
//#pragma UIWebViewDelegate
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [SVProgressHUD show];
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [SVProgressHUD dismiss];
//    CGRect frame = webView.frame;
//    CGSize mWebViewTextSize = [webView sizeThatFits:CGSizeMake(1.0f, 1.0f)];
//    frame.size = mWebViewTextSize;
//    self.webView.frame = frame;
////    [self.tableView reloadData];
//}
@end
