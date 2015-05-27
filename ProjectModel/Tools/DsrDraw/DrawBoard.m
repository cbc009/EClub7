//
//  DrawBoard.m
//  DrawLine
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 dengshiru. All rights reserved.
//

#import "DrawBoard.h"

@implementation DrawBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:32], NSFontAttributeName, [UIColor redColor], NSForegroundColorAttributeName, nil];
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *str=self.prize;
    CGSize aa = [str sizeWithAttributes:attrs];
    
    [str drawAtPoint:CGPointMake((self.frame.size.width-aa.width)/2, 10) withAttributes:attrs];
    CGContextStrokePath(context);    
}
 

@end
