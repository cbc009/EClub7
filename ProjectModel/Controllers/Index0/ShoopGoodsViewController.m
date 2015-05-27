//
//  ShoopGoodsViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShoopGoodsViewController.h"
#import "CheckedViewController.h"
#import <UIImageView+WebCache.h>
@interface ShoopGoodsViewController ()
//{
//    SellerService *SellerService;
//}
@end

@implementation ShoopGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.models.goods_name;
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
    [self setValue];
}

-(void)setValue{
    [self.bigPicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.models.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
    self.goodName.text=self.models.goods_name;
    self.price.text=self.models.price;
    self.vipPrice.text=self.models.discount;
    self.address.text=self.models.receive_address;
    self.workTime.text =[NSString stringWithFormat:@"%@-%@",self.models.send_time[0],self.models.send_time[1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addnumbs:(id)sender {
    self.numbs.text=[SharedAction addNumber:self.numbs];
}

- (IBAction)reduceNumbs:(id)sender {
    self.numbs.text=[SharedAction reduceNumber:self.numbs];
}

- (IBAction)share:(id)sender {
    NSString *share_url=[NSString stringWithFormat:Seller_Seller_Goods_Share_URL,self.models.goods_id];
     [SharedAction shareWithTitle:self.title andDesinationUrl:share_url Text:self.models.goods_name andImageUrl:[NSString stringWithFormat:@"%@%@",IP,self.models.bigpicture] InViewController:self];
}

- (IBAction)buyNow:(id)sender {
    UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    CheckedViewController *checkedViewController=[storyBoard instantiateViewControllerWithIdentifier:@"CheckedViewController"];
    checkedViewController.models=self.models;
    checkedViewController.numbs=self.numbs.text;
    [self.navigationController pushViewController:checkedViewController animated:YES];
}
@end
