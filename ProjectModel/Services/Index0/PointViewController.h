//
//  PointViewController.h
//  Club
//
//  Created by MartinLi on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (copy ,nonatomic) NSString *indexPath;
@property (assign ,nonatomic) NSInteger page;
@property (assign ,nonatomic) NSMutableArray *datas2;
@property (strong ,nonatomic) NSMutableArray *datas;
@end
