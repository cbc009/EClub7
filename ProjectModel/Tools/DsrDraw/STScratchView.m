//
//  DrawBoard.m
//  DrawLine
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 dengshiru. All rights reserved.
//

#import "STScratchView.h"
#define FH_GetWithImage(a,b) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:a ofType:b]]
@implementation STScratchView
{
    BOOL ISENBALE;
    NSInteger post;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        ISENBALE=YES;
        _sizeBrush = 10.0;
    }
    return self;
}

#pragma mark -
#pragma mark CoreGraphics methods

// Will be called every touch and at the first init
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIImage *imageToDraw = [UIImage imageWithCGImage:scratchImage];
    [imageToDraw drawInRect:CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height)];
}

// Method to change the view which will be scratched
- (void)setHideView:(UIView *)hideView
{
    post=0;//0可以提交1不可提交
    UIView *mainView = [[UIView alloc] initWithFrame:self.bounds];
    [mainView setBackgroundColor:[UIColor clearColor]];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height)];
    [self.imageView setBackgroundColor:[UIColor clearColor]];
    [self.imageView setContentMode:UIViewContentModeScaleToFill];
    [self.imageView setImage:FH_GetWithImage(@"ShadeTouchHintImg", @"png")];
    [mainView addSubview:self.imageView];
    [self addSubview:mainView];
}

#pragma mark -
#pragma mark Touch event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [[event touchesForView:self] anyObject];
    currentTouchLocation = [touch locationInView:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(ISENBALE)
    {
        CGPoint currentPoint = [touch locationInView:self.imageView];
        UIGraphicsBeginImageContext(self.imageView.frame.size);
        [self.imageView.image drawInRect:self.imageView.bounds];
        
        //关键是这个地方。如何才能做成不规则的图形 －－－－－－－－－－－－－－－－－－－－－－－－－
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect cirleRect = CGRectMake(currentPoint.x-10, currentPoint.y-10, 20, 20);
        
        //下面是一句画出圆形的
        CGContextAddArc(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y, 10, 0.0, 2*M_PI, 0);
        
        //下面我绘制了一个三角形
//        CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
        CGContextAddLineToPoint(context, currentPoint.x+20, currentPoint.y+30);
        CGContextAddLineToPoint(context,currentPoint.x-10, currentPoint.y+20);
        CGContextAddLineToPoint(context,currentPoint.x-20, currentPoint.y+20);
        CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
        //向例子图片那样的不规则手指形状该怎么弄。都用CGContextAddLineToPoint绘制出来？？？
        CGContextClosePath(context);
        CGContextClosePath(context);
        CGContextClip(context);
        
        CGContextClearRect(context,cirleRect);
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        if (post==0) {
            if (currentPoint.x>55&currentPoint.y>15&currentPoint.x<208&currentPoint.y<39) {
                post=1;
                [self.delegate postPrizeidinView:self];
            }
        }
        UIGraphicsEndImageContext();

    }
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
//    UITouch *touch = [[event touchesForView:self] anyObject];
    if(ISENBALE)
    {
//        CGPoint currentPoint = [touch locationInView:self.imageView];
//        UIGraphicsBeginImageContext(self.imageView.frame.size);
//        [self.imageView.image drawInRect:self.imageView.bounds];
//        
//        CGContextClearRect (UIGraphicsGetCurrentContext(), CGRectMake(currentPoint.x-10, currentPoint.y-10, 20, 20));
//        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
    }

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}

- (void)initScratch
{
    currentTouchLocation = CGPointZero;
    previousTouchLocation = CGPointZero;
}

@end
