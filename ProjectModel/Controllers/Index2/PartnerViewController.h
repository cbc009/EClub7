//
//  PartnerViewController.h
//  Club
//
//  Created by MartinLi on 15-1-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *datas;
@end
