//
//  DrawBoard.m
//  DrawLine
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 dengshiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class STScratchView;
@protocol PostPrizeidDelegate<NSObject>
-(void)postPrizeidinView:(STScratchView*)view;
@end
@interface STScratchView : UIView
{
    CGPoint previousTouchLocation;
    CGPoint currentTouchLocation;
    
    CGImageRef hideImage;
    CGImageRef scratchImage;

	CGContextRef contextMask;
}
@property (nonatomic,weak)id<PostPrizeidDelegate>delegate;
@property (nonatomic, assign) float percentAccomplishment;
@property (nonatomic, assign) float sizeBrush;
@property (nonatomic,strong)    UIImageView *imageView ;
@property (nonatomic, strong) UIView *hideView;

- (void)setHideView:(UIView *)hideView;

@end
