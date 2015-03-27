//
//  RemarkViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RemarkViewController.h"
#import "BigRatingBar.h"
@interface RemarkViewController ()
{
    BigRatingBar *bar;
}
@end

@implementation RemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i=0; i<4; i++) {
        bar = [[BigRatingBar alloc] initWithFrame:CGRectMake(75, 60, 160, 20)];
        bar.tag=i;
        bar.frame=CGRectMake(90, 15+43*i, 100, 20);
        [self.backView addSubview:bar];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"%ld,%ld",(long)bar.tag,(long)bar.starNumber);
    self.mTextview.text=@"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
