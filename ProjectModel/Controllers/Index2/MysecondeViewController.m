//
//  MysecondeViewController.m
//  Club
//
//  Created by MartinLi on 14-12-24.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "MysecondeViewController.h"
#import "MySecondTableViewCell.h"
#import "SecondeService.h"
#import "SharedData.h"
#import "Login.h"
@interface MysecondeViewController ()
{
    SecondeService *secondeService;
    NSInteger page;
    UserInfo *user;
}
@end

@implementation MysecondeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page =1;

    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    secondeService = [[SecondeService alloc] init];
    [secondeService loadMyTransDataWithMid:user.mid andPage:pageString onMysecondeViewController:self];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySecondTableViewCell" forIndexPath:indexPath];
    NSDictionary *dic = self.datas[indexPath.section];
     NSLog(@"%@",dic);
    cell.name.text = [dic valueForKey:@"name"];
    cell.time.text = [dic valueForKey:@"regtime"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)segment:(UISegmentedControl *)sender {
    page = 1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    if (sender.selectedSegmentIndex==1) {
        [secondeService loadMyBuyDataWithMid:user.mid andPage:pageString onMysecondeViewController:self];
        
    }else{
        [secondeService loadMyTransDataWithMid:user.mid andPage:pageString onMysecondeViewController:self];
    }

}
@end
