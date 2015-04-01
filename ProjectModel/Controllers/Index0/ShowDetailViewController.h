//
//  ShowDetailViewController.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSString *seller_id;

@end
