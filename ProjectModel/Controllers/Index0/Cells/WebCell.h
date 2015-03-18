//
//  WebCell.h
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebCell : UITableViewCell <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong)NSString *robGoodsid;
@end
