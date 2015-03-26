//
//  RemarkViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RemarkViewController.h"
#import "RatingBar.h"
@interface RemarkViewController ()
{
    RatingBar *bar;
}
@end

@implementation RemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backScroller.scrollEnabled=NO;
    bar = [[RatingBar alloc] initWithFrame:CGRectMake(75, 50, 160, 20)];
    [self.backView addSubview:bar];
    bar.starNumber=2.5;
//    bar.enable=NO;
    bar.frame=CGRectMake(80, 140, 100, 20);
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
