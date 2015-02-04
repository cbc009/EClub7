//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"

@interface SKTagButton ()
@property (nonatomic, strong) SKTag *mTag;
@end

@implementation SKTagButton

+ (instancetype)buttonWithTag:(SKTag *)tag
{
    SKTagButton *btn = [super buttonWithType:UIButtonTypeSystem];
    btn.mTag = tag;
    [btn setTitle:tag.text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:tag.fontSize];
    btn.frame=CGRectMake(0, 0, 98, 50);
    btn.backgroundColor = tag.bgColor;
    [btn setTitleColor:tag.textColor forState:UIControlStateNormal];
    [btn addTarget:tag.target action:tag.action forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = tag.cornerRadius;
//    btn.layer.masksToBounds = YES;
    [btn.layer setBorderWidth:1.5];   //边框宽度
    [btn.layer setBorderColor:[UIColor grayColor].CGColor];//边框颜色
    [btn setContentEdgeInsets:tag.padding];
    return btn;
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    return size;
}

@end
