//
//  DsrCollectionViewController.h
//  Club
//
//  Created by MartinLi on 15-1-12.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosenImageCell.h"
@interface DsrCollectionViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collcetion;
@property (nonatomic,strong) NSArray *imageUrls;
@property(nonatomic,strong)UIViewController *fatherController;
@property(nonatomic,strong)UIView *superView;
@property(nonatomic,assign)float collectionviewHeight;
@end
