//
//  FeedbackViewController.m
//  Club
//
//  Created by dongway on 14-8-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackService.h"
#import "Status.h"
#import "FeedBackCell.h"
#import "FeedRequestCell.h"
#import "FeedbackModel.h"
#import <UIImageView+WebCache.h>
#import "NSString+MT.h"
@interface FeedbackViewController ()
{
    FeedbackService *feedbackService;
    UIKeyboardViewController *keyBoardController;
    UserInfo *user;
}
@end

@implementation FeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)loadView{
    [super loadView];
    SharedData *sharedData = [SharedData sharedInstance];
    user=sharedData.user;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    feedbackService = [[FeedbackService alloc] init];
    [feedbackService baseMyadviceWithToken:user.token andUser_Type:user.user_type intabBarController:self.tabBarController withDone:^(Feedback_info *model){
        self.datas = (NSArray *)model.advice;
        [self.tableview reloadData];
    }];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *CellIdentifier =@"FeedBackCell";
        FeedBackCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (cell==nil) {
            cell = [[FeedBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.delegate=self;
        return cell;
    }else {
        Advice_Info *object = self.datas[indexPath.row];
        FeedRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedRequestCell" forIndexPath:indexPath];
        cell.regtime.text = object.regtime;
        [cell.heard sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.heard.layer.masksToBounds = YES;
        cell.heard.layer.cornerRadius = 20;
        cell.heard2.layer.masksToBounds=YES;
         cell.heard2.layer.cornerRadius = 20;
        cell.content.text=object.content;
         cell.contentBackHeight.constant =[NSString heightWithString:object.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(212, 600)]+10;
        cell.contentWidth.constant=[NSString widthWithString:object.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(212, 600)]+27;
        if ([object.reply isEqualToString:@""]) {
            cell.requestback.hidden=YES;
            cell.request.hidden=YES;
            cell.heard2.hidden = YES;
            cell.retime.hidden=YES;
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            cell.retime.text = object.oprttime;
            cell.request.text=object.reply;
            
            cell.requestHeight.constant =[NSString heightWithString:object.reply font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(212, 600)]+10;
            cell.reauestWidth.constant=[NSString widthWithString:object.reply font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(212, 600)]+33;
            cell.heard2.hidden = NO;
            cell.retime.hidden=NO;
            cell.request.hidden=NO;
            cell.requestback.hidden=NO;
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
        //输入框失去焦点，隐藏键盘
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0){
        return 168;
    }else{
        Advice_Info *object = self.datas[indexPath.row];
        if ([object.reply isEqualToString:@""]) {
            return [NSString heightWithString:object.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(212, 600)]+60;
        }else{
            return [NSString heightWithString:object.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(212, 600)]+50+[NSString heightWithString:object.reply font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(190, 600)]+40;
        }
    }
}
-(void)feedbackInCell:(FeedBackCell *)cell{
    [feedbackService submitWithContent:cell.myFeedback.text withToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(id model){
        if ([model[@"status"] isEqualToNumber: @2]) {
            [SVProgressHUD showSuccessWithStatus:@" 感谢您的反馈!"];
        }else{
            [SVProgressHUD showErrorWithStatus:model[@"error"]];
        }
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
