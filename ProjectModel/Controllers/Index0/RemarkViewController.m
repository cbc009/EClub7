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
#import "RemarkService.h"
#import "Status.h"
@interface RemarkViewController ()<BigRatingBarDelegate>
{
    BigRatingBar *ratingbar;
    RemarkService *remarkService;
    NSInteger starNumber0;
    NSInteger starNumber1;
    NSInteger starNumber2;
    NSInteger starNumber3;
    UserInfo *user;
}
@end

@implementation RemarkViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title=@"点评";
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    starNumber0=0;
    starNumber1=0;
    starNumber2=0;
    starNumber3=0;
    
    remarkService =[RemarkService new];
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
            starNumber0=starNumber+1;
            break;
        case 1:
            self.index1.text=str;
            starNumber1=starNumber+1;
            break;
        case 2:
            self.index2.text=str;
            starNumber2=starNumber+1;
            break;
        case 3:
            self.index3.text=str;
            starNumber3=starNumber+1;
            break;
        default:
            break;
    }
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.mTextview.text=@"";
    self.mTextview.textColor=[UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postremark:(id)sender {
    //这里的数字 1或者0 或者 @“” 可以看文档 就是他有些要求是这样的 
    [remarkService seller_comment_releaseWuthType:@"1" andSeller_id:self.models.seller_id andContent:self.mTextview.text andPraise_nums:@"0" andComment_id:@"" andOther_id:@"" andTotal_praises:[NSString stringWithFormat:@"%ld",(long)starNumber0] andAttitude_praises:[NSString stringWithFormat:@"%ld",(long)starNumber1] andNeat_praises:[NSString stringWithFormat:@"%ld",(long)starNumber2] andDescrip_praises:[NSString stringWithFormat:@"%ld",(long)starNumber3] andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(Status *model){
            [SVProgressHUD showSuccessWithStatus:@"感谢您的评论"];
            [self.navigationController popViewControllerAnimated:YES];
    }];
    
}
- (IBAction)post:(id)sender {
    //这里的数字 1或者0 或者 @“” 可以看文档 就是他有些要求是这样的
    [remarkService seller_comment_releaseWuthType:@"1" andSeller_id:self.models.seller_id andContent:self.mTextview.text andPraise_nums:@"0" andComment_id:@"" andOther_id:@"" andTotal_praises:[NSString stringWithFormat:@"%ld",(long)starNumber0] andAttitude_praises:[NSString stringWithFormat:@"%ld",(long)starNumber1] andNeat_praises:[NSString stringWithFormat:@"%ld",(long)starNumber2] andDescrip_praises:[NSString stringWithFormat:@"%ld",(long)starNumber3] andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(id model){
        if ([model[@"status"] isEqualToNumber: @2]) {
            [SVProgressHUD showSuccessWithStatus:@"感谢您的评论"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
