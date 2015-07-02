//
//  BackGroundCell.m
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "BackGroundCell.h"
#import <UIImageView+WebCache.h>
@implementation BackGroundCell
{
     UIImageView *backImage;
}
- (void)awakeFromNib {
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    backImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceFrame.size.width+20,135)];
    [backImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.imageName]] placeholderImage:[UIImage imageNamed:@"e"]];
    [backImage.layer addAnimation:[self moveX:4 X:@10] forKey:nil];
   
    [self.backView addSubview:backImage];
}

-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x //横向移动

{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animation.duration=time;
    
    animation.autoreverses=YES;
    
    animation.repeatCount=100;
    
    animation.toValue=[NSNumber numberWithInt:-10];
    
    animation.fromValue=[NSNumber numberWithInt:-26];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return animation;
    
}
@end
