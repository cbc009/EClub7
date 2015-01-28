//
//  UPPayViewController.h
//  Club
//
//  Created by MartinLi on 15-1-22.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPPayPluginDelegate.h"

@interface UPPayViewController : UIViewController<UPPayPluginDelegate>
@property (nonatomic,strong)NSString *tn;
@property(nonatomic, copy)NSString *tnMode;
@end
