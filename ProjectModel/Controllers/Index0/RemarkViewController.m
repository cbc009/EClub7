//
//  RemarkViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RemarkViewController.h"
#import "BigRatingBar.h"
#import <UIImageView+WebCache.h>
@interface RemarkViewController ()<BigRatingBarDelegate>
{
    BigRatingBar *ratingbar;
}
@end

@implementation RemarkViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.sellerName.text=self.models.seller_name;
    [self.sellerPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.models.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    
    for (int i=0; i<4; i++) {
        ratingbar = [[BigRatingBar alloc] initWithFrame:CGRectMake(75, 15+42*i, 160, 20)];
        ratingbar.frame=CGRectMake(90, 15+42*i, 140, 20);
        ratingbar.tag=i;
        ratingbar.delegate=self;
        [self.backView addSubview:ratingbar];
    }
}
-(void)senderStarNumber:(NSInteger)starNumber withBar:(BigRatingBar*)bar{
    NSString *str=[NSString stringWithFormat:@"%ld分",(long)starNumber+1];
    switch (bar.tag) {
        case 0:
            self.index0.text=str;
            break;
        case 1:
            self.index1.text=str;;
            break;
        case 2:
            self.index2.text=str;;
            break;
        case 3:
            self.index3.text=str;
            break;
        default:
            break;
    }
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.mTextview.text=@"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postremark:(id)sender {
    
}
@end
