//
//  LiveViewController.m
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveService.h"
#import "SharedData.h"
#import "Login.h"
#import "BackGroundCell.h"
#import "BodyCell.h"
#import "LiveModel.h"
#import "LiveData.h"
#import <UIImageView+WebCache.h>
@interface LiveViewController ()
{
    LiveService *liveService;
    UserInfo *user;
    NSInteger h;
    NSInteger label_height;
    DataInfo *model;

}
@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = YES;
    SharedData *sharedData = [SharedData sharedInstance];
    self.labeHeightlArray = [[NSMutableArray alloc] init];
    self.cellHeightlArray = [[NSMutableArray alloc] init];
     self.tableViewheightArray = [[NSMutableArray alloc] init];
    user = sharedData.user;
    liveService = [[LiveService alloc] init];
    [liveService loadLiveDataWithToken:user.token andUser_type:user.user_type onLiveViewController:self];
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self.tableview reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return  1;
    }else{
        return self.datas.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        BackGroundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackGroundCell" forIndexPath:indexPath];
        [cell.herad sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        [cell.back sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.life_picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else{
        static NSString *CellIdentifier =@"BodyCell";
        BodyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell = [[BodyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        model = self.datas[indexPath.row];
        cell.nickname.text=model.nickname;
        cell.comment.text = model.content;
        cell.time.text = model.regtime;
        if (model.comment.count==0) {
            cell.tableHeight.constant = 0;
        }else{
            cell.data =(NSMutableArray *)model.comment;
            NSLog(@"%@,%ld",cell.data,indexPath.row);
            cell.tableHeight.constant = [self.tableViewheightArray[indexPath.row]floatValue];
        }
        cell.tableFarm.constant = 12;
        [cell.herad sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
         return 150;
    }else{
        return [self.cellHeightlArray[indexPath.row] floatValue];

    }
   
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
