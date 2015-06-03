//
//  WebDetailViewCell.h
//  Club
//
//  Created by MartinLi on 15/6/1.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebDetailViewCell : UITableViewCell<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic,strong)NSString *urlString;
@end
