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
#import "APPQRCodeCell.h"
#import "JoinMemberCell.h"
#import "RecommendCell.h"
@interface AppViewController ()

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
//    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [appQRcodeService loadDataWithToken:sharedData.user.token AndUser_type:sharedData.user.user_type withDone:^(GUIde_info *model){
        self.qrCode = model.qrcode;
        self.datas = (NSArray*)model.member;
        [self.tableView reloadData];
    }];
    
}
#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return self.datas.count;
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        APPQRCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"APPQRCodeCell" forIndexPath:indexPath];
         cell.QRCimage.image = [QRCodeGenerator qrImageForString:self.qrCode imageSize:cell.QRCimage.frame.size.width];
        return cell;
    }else if (indexPath.section==2){
        NSInteger row = indexPath.row;
        JoinMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinMemberCell" forIndexPath:indexPath];
        Member_info *model =self.datas[row];
        cell.name.text =model.nickname;
        [cell.picture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else{
        RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendCell" forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 317;
    }else  if (indexPath.section==1){
        return 40;
    }else{
        return 60;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    [SharedAction shareWithTitle:@"E小区" andDesinationUrl:self.qrCode  Text:@"最近在用'E小区'在线免费抢菜，抽奖，秒杀，买菜，感觉挺好的，小小的推荐一下。" andImageUrl:@"qrenCode.jpg" InViewController:self];
}



@end
