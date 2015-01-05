//
//  AppViewController.m
//  Club
//
//  Created by MartinLi on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "AppViewController.h"
#import "SharedAction.h"
#import <UIImageView+WebCache.h>
#import "QRCodeGenerator.h"
#import "AppQRocde.h"
@interface AppViewController ()
{
    NSString *qrcodeURL;
}
@end

@implementation AppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"应用推荐";
    SharedData *sharedData = [SharedData sharedInstance];
    AppQRocde *appQRcodeService = [[AppQRocde alloc] init];
    [appQRcodeService loadDataWithToken:sharedData.user.token AndUser_type:sharedData.user.user_type withDone:^(GUIde_info *model){
        self.QRCode.image = [QRCodeGenerator qrImageForString:model.qrcode imageSize:self.QRCode.frame.size.width];
        qrcodeURL = model.qrcode;
        NSLog(@"%@",model.qrcode);
    }];
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
- (IBAction)shareAction:(id)sender {
    [SharedAction shareWithTitle:@"E小区" andDesinationUrl:qrcodeURL Text:@"最近在用'E小区'在线免费抢菜，抽奖，秒杀，买菜，感觉挺好的，小小的推荐一下。" andImageUrl:@"qrenCode.jpg" InViewController:self];
}



@end
