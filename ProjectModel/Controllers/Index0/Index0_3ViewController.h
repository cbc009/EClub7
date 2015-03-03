//
//  Index0_3ViewController.h
//  Club
//
//  Created by Gao Huang on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MartinLiPageScrollView.h"
#import <CoreLocation/CoreLocation.h>
@protocol stringDelegate<NSObject>
-(void)passData:(NSArray *)datas;
@end
@interface Index0_3ViewController : UIViewController<UITabBarDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,MartinLiPageScrollViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSArray *balance;
@property(nonatomic,strong)NSArray *pageviewDatas;
@property(nonatomic,strong)NSArray *goodTypes;
@property(nonatomic,strong)NSArray *collectionDatas;
@property(nonatomic,strong)NSArray *collectionImgs;
@end
