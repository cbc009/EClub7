//
//  Index1_5Cell.h
//  Club
//
//  Created by MartinLi on 15-4-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Index1_5Cell.h"
@class Index1_5Cell;
@protocol SelectIndexDelegate<NSObject>
-(void)selectIndexInCell:(Index1_5Cell*)cell andSellerId:(NSString *)seller_id;
-(void)scrollViewScrollEnable:(BOOL)enable;
@end

@interface Index1_5Cell : UITableViewCell
@property (nonatomic,weak)id <SelectIndexDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *datas;
@end
