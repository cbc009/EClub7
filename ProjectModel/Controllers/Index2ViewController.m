//
//  Index2ViewController.m
//  ProjectModel
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index2ViewController.h"
#import "SVProgressHUD.h"
#import "Index3_1Cell.h"
#import "Index2Service.h"
@interface Index2ViewController ()
{
    
    NSArray *images;
    NSArray *titles;
    Index2Service *index2Service;
}
@end

@implementation Index2ViewController

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    index2Service = [[Index2Service alloc] init];
    // Do any additional setup after loading the view.
    images = [[NSArray alloc] initWithObjects:@"living_circle",@"project",@"main_custom_manage",@"order",@"jiaoyi",nil];
    titles = [[NSArray alloc]initWithObjects:@"生活圈",@"生活体验馆",@"合作商家",@"快递查询",@"水煤电缴费",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = indexPath.row;
    static NSString *identifier = @"Index3_1Cell";
    Index3_1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:[images objectAtIndex:row]];
    cell.title.text = [titles objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (row) {
        case 1:
            [index2Service presenterLifeHallViewControllerOnViewController:self];
            break;
        case 0:
            [index2Service presentLiveViewControllerOnViewController:self];
            break;
        case 2:
            [index2Service presenterPartnerViewControllerOnViewController:self];
            break;
        case 3:
             [index2Service presentEmsViewControllerOnViewController:self];
            break;
        case 4:
            [index2Service presentAlipayViewControllerOnViewController:self];
            break;
        default:
            NSLog(@"didSelect:%ld",(long)section);
            [SVProgressHUD showImage:nil status:@"功能尚未开放，敬请期待"];
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

@end
