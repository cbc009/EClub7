//
//  PeopleDetailViewController.m
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PeopleDetailViewController.h"
#import "BackGroundCell.h"
#import "PeopleDetailCell.h"
#import "PeopleDetailService.h"
#import "LiveModel.h"
#import <UIImageView+WebCache.h>
@interface PeopleDetailViewController ()
{
    UserInfo *user;
    LiveModelInfo *object;
}
@end

@implementation PeopleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.cellHeightArray = [[NSMutableArray alloc] init];
     self.labelHeightArrar = [[NSMutableArray alloc] init];
    PeopleDetailService *peopleDetailService = [[PeopleDetailService alloc] init];
    [peopleDetailService LifecircleMyinfoWithMid:self.mid andToken:user.token andUser_type:user.user_type withTabBarController:self.tabBarController witDoneObject:^(LiveModelInfo *model1){
        object =model1;
        self.datas=(NSArray *)model1.data;
        [peopleDetailService countSizeWithData:self.datas inViewController:self];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITableViewDataSource
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
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
       [cell.herad sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object.headpic]] placeholderImage:[UIImage imageNamed:@"e"]];
        NSLog(@"%@",object.life_picture);
        [cell.back sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object.life_picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }else{
        static NSString *CellIdentifier =@"PeopleDetailCell";
        PeopleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (cell==nil) {
            cell = [[PeopleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        DataInfo *model = self.datas[indexPath.row];
        cell.message.text = model.content;
        cell.time.text=model.regtime;
        cell.lableHeight.constant = [self.labelHeightArrar[indexPath.row] floatValue];
        cell.collectionDatas = (NSArray *)model.picture;
        if (cell.collectionDatas.count<1) {
            cell.collection.hidden=YES;
        }
        return cell;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==5) {
        if(buttonIndex==1){
            [SharedAction loginAggane];
            NSArray *viewControllers = self.navigationController.viewControllers;
            [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 150;
    }else if (indexPath.section==1){
        return [self.cellHeightArray[indexPath.row] floatValue];
    }else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
