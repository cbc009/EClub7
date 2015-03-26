//
//  ShoopGoodsViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShoopGoodsViewController.h"

@interface ShoopGoodsViewController ()

@end

@implementation ShoopGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reduce.layer.cornerRadius=2;
    self.reduce.layer.borderWidth=1;
    self.reduce.layer.borderColor=[UIColor redColor].CGColor;
  
    self.add.layer.cornerRadius=2;
    self.add.layer.borderWidth=1;
    self.add.layer.borderColor=[UIColor redColor].CGColor;
    
    self.numbs.layer.cornerRadius=2;
    self.numbs.layer.borderWidth=1;
    self.numbs.layer.borderColor=[UIColor redColor].CGColor;
    
    self.buyNow.layer.cornerRadius=4;
    self.scrollView.autoresizesSubviews=YES;
    // Do any additional setup after loading the view.
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

- (IBAction)addnumbs:(id)sender {
    self.numbs.text=[SharedAction addNumber:self.numbs];
}
- (IBAction)reduceNumbs:(id)sender {
    self.numbs.text=[SharedAction reduceNumber:self.numbs];
}
- (IBAction)share:(id)sender {
//     [SharedAction shareWithTitle:self.title andDesinationUrl:self.goodModel.share_url Text:self.goodModel.name andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.goodModel.bigpicture] InViewController:self];
}
@end
