//
//  Index1_7Cell.h
//  Club
//
//  Created by MartinLi on 15-4-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Index1_7Cell.h"
@class Index1_7Cell;
@protocol SelectedIndexDelegate<NSObject>
-(void)selectIndexInCell:(Index1_7Cell*)cell andGoodsId:(NSString *)goodId;
@end
@interface Index1_7Cell : UITableViewCell<UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak)id <SelectedIndexDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collictionView;
@property (nonatomic,strong)NSArray *datas;

@end
