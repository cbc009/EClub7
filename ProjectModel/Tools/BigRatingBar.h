//
//  BigRatingBar.h
//  Club
//
//  Created by MartinLi on 15-3-27.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigRatingBar : UIView
@property (nonatomic,assign) NSInteger starNumber;

@property (nonatomic,assign) CGFloat witSize;
/*
 *调整底部视图的颜色
 */
@property (nonatomic,strong) UIColor *viewColor;

/*
 *是否允许可触摸
 */
@property (nonatomic,assign) BOOL enable;
@end
