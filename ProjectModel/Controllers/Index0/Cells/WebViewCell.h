//
//  WebViewCell.h
//  Club
//
//  Created by MartinLi on 14-12-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;
@end
