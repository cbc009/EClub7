//
//  WebDetailViewCell.m
//  Club
//
//  Created by MartinLi on 15/6/1.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "WebDetailViewCell.h"

@implementation WebDetailViewCell

- (void)awakeFromNib {
    self.webview.delegate=self;
    self.webview.scrollView.scrollEnabled=NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
//        [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    [SVProgressHUD dismiss];
    CGRect frame = webView.frame;
    CGSize mWebViewTextSize = [webView sizeThatFits:CGSizeMake(1.0f, 1.0f)];
    frame.size = mWebViewTextSize;
    //    self.webview.frame = frame;
    //    self.webviewHeight.constant = mWebViewTextSize.height;
    //    [self.scrollview setContentSize:CGSizeMake(DeviceFrame.size.width, mWebViewTextSize.height+442)];
}
@end
