//
//  Shoop_1Cell.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShowMoreItemsCellDelegate <NSObject>

@optional
-(void)moreItmes:(id)sender InCell:(UITableViewCell *)cell;
-(void)pushShoopsGoodVicIncell:(UITableViewCell *)cell;
@end
@interface Shoop_1Cell : UITableViewCell
@property(nonatomic,retain)id<ShowMoreItemsCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property(nonatomic,strong)NSArray *datas;
- (IBAction)more:(id)sender;

@end
