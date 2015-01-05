//
//  ItemDetailViewController.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

//
//  ItemDetailViewController.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ItemDetailService.h"
#import <UIImageView+WebCache.h>
#import "PurchaseCarItemsViewController.h"
#import "WebViewController.h"
#import "MLFloatButton.h"
#import "SharedData.h"
#import "Login.h"
@interface ItemDetailViewController ()<MLFloatButtonDelegate>
{
    ItemDetailService *itemDetailService;
    WebViewController *target;
    NSString *gid;
}
@end

@implementation ItemDetailViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        itemDetailService = [[ItemDetailService alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

        self.title = self.goodModel.name;
        gid = self.goodModel.gid;
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.goodModel.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
        self.currentPrice.text = [NSString stringWithFormat:@"%@元/%@",self.goodModel.discount,self.goodModel.unit];
        self.pastPrice.text = [NSString stringWithFormat:@"%@元/%@",self.goodModel.price,self.goodModel.unit];
        self.count.text = self.goodModel.unit_num;
        self.Ems.text = self.goodModel.logistics;
        self.floatButton = [MLFloatButton loadFromNibAddTarget :self InSuperView:self.view];
}


-(void)buttonTouchAction
{
    PurchaseCarItemsViewController *purchaseCar = [self.storyboard instantiateViewControllerWithIdentifier:@"PurchaseCarItemsViewController"];
    [self.navigationController pushViewController:purchaseCar animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reduceAction:(id)sender {
    self.count.text = [itemDetailService reduceNumber:self.count];
}

- (IBAction)addAction:(id)sender {
    self.count.text = [itemDetailService addNumber:self.count];
}

- (IBAction)buyAction:(id)sender {
   }

- (IBAction)addToPurchaseCar:(id)sender {
    NSString *num = self.count.text;
    [itemDetailService addToPurchaseCarWithGid:gid andNum:num];
}

- (IBAction)buynow:(id)sender {
    //立即购买
    NSString *count = self.count.text;
    [itemDetailService presentPurchaseCarViewControllerOnViewController:self andItemCount:count];
    
}
- (IBAction)segMent:(UISegmentedControl *)sender {
   
    if (sender.selectedSegmentIndex==0) {
        [target.view removeFromSuperview];
        [target removeFromParentViewController];
    }else{
        if (!target) {
            target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
            target.urlString = self.goodModel.url;
            [target.view layoutSubviews];
            NSLog(@"%@",target.urlString);
//            target.view.frame = CGRectMake(0, NavigationBarFrame.size.height+StatusBarFrame.size.height, DeviceFrame.size.width, DeviceFrame.size.height-NavigationBarFrame.size.height+StatusBarFrame.size.height);
        }
        [self addChildViewController:target];
        [self.view addSubview:target.view];
    }
}


@end
