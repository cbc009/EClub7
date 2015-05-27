//
//  Index3ViewController.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index3ViewController.h"
#import "Index3Service.h"
#import "SVProgressHUD.h"
#import "UserDefaults.h"
#import "Index3_1Cell.h"
#import "Index3_2Cell.h"
#import "SharedData.h"
#import "Member_Login.h"
#import <UIImageView+WebCache.h>
#import "LoginViewController.h"
@interface Index3ViewController () <UITableViewDelegate,UITableViewDataSource,LoginViewControllerDelegate>
{
    NSArray *images;
    NSArray *images1;
    NSArray *titles;
    NSArray *titles1;
    UserInfo *user;
    Index3Service *index3Service;
}
@end

@implementation Index3ViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        index3Service = [[Index3Service alloc] init];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LoginViewController *login = [[LoginViewController alloc] init];
    login.delegate=self;
    _tableview.showsVerticalScrollIndicator =NO;
    
    _tableview.tableFooterView = [[UIView alloc] init];
    // Do any additional setup after loading the view.
    images = [[NSArray alloc]
              initWithObjects:@"mywallet",@"code",@"myorder",nil];
    images1=[[NSArray alloc]initWithObjects:@"feedback",@"sharewith",nil];
    titles = [[NSArray alloc] initWithObjects:@"我的钱包",@"我的二维码",@"我的订单",nil];
    titles1 = [[NSArray alloc]initWithObjects:@"意见反馈",@"应用推荐",nil];
    [self.tableview reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.tabBarController.tabBar.hidden=NO;
    [self.tableview reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"pushToSet"]) {
        UIViewController *target = segue.destinationViewController;
        target.hidesBottomBarWhenPushed = YES;
    }
}

#pragma UITableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 2;
            break;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    NSString *identifier;
    if (section==0) {
        identifier = @"Index3_2Cell";
        Index3_2Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.imgView.layer.masksToBounds = YES;
        cell.imgView.layer.cornerRadius = 32;
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.picture]] placeholderImage:[UIImage imageNamed:@"userIcon.jpg"]];
//        cell.address.text = user.sname;
        cell.address.hidden=YES;
        cell.nickname.text = user.nickname;
        return cell;
    }else if(section==1) {
        identifier = @"Index3_1Cell";
        Index3_1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.imgView.image = [UIImage imageNamed:images[row]];
        cell.title.text = titles[row];
        return cell;
    }else if(section==2) {
        identifier = @"Index3_1Cell";
        Index3_1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.imgView.image = [UIImage imageNamed:@"contactus"];
        cell.title.text = @"联系我们";
        return cell;
    }else{
        identifier = @"Index3_1Cell";
        Index3_1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.imgView.image = [UIImage imageNamed:images1[row]];
        cell.title.text = titles1[row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    if (section==0) {
        [index3Service presentUserDetailViewControllerOnViewController:self];
    }else if(section==1){
        switch (row) {
            case 0:
                [index3Service presentMyWalletViewControllerOnViewController:self];
                break;
            case 1:
                [index3Service presentQRCodeViewControllerOnViewController:self];
                break;
            case 2:
                [index3Service presentMyOrderViewControllerOnViewController:self];
                break;
            default:
                [SVProgressHUD showImage:nil status:@"功能尚未开放，敬请期待"];
                break;
        }
        }else if(section==2){
                [index3Service callWithPhoneNumber:user.phone InViewController:self];
        }else{
            switch (row) {
            case 0:
                [index3Service presentFeedBackViewControllerOnViewController:self];
                break;
            case 1:
                [index3Service presentAppViewControllerOnViewController:self];
                break;
            default:
                [SVProgressHUD showImage:nil status:@"功能尚未开放，敬请期待"];
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
            return 80;
            break;
        default:
            return 54;
    }
}
#pragma LoginViewControllerDelegate
-(void)loginSuccessedActionWithViewController:(UIViewController *)viewController{
    [_tableview reloadData];
    [viewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 10;
    }else{
        return 8;
    }
    
}


@end
