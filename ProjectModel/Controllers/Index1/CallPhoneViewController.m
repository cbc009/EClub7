//
//  CallPhoneViewController.m
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "CallPhoneViewController.h"
#import "CallService.h"
#import "ButtonVIew.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "CallHistoryService.h"
#import "CallHistoryViewCell.h"
#import "Call_history_Model.h"
#import "CallPhone.h"
#import "SharedData.h"
#import "BalanceData.h"
#import "BalanceModel.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "WebViewController.h"
#import "Index0Service.h"
#import "Base_Balance_Model.h"
#import "SiginModel.h"
#define width self.view.frame.size.width
#define height1 self.view.frame.size.height
@interface CallPhoneViewController ()<ABPeoplePickerNavigationControllerDelegate>
{
    int columnCount;
    CallHistoryService *callhistoryservice;
    CallService *call;
    NSDictionary *dic;
    NSInteger page;
    ButtonVIew *btnView;
    UIButton *btn2;
    UserInfo *user;
    int j;//0键盘隐藏状态，1键盘显示状态
}
@end

@implementation CallPhoneViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=NO;
    [SharedAction setupRefreshWithTableView:self.tableView toTarget:self];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.minutes.text = [NSString stringWithFormat:@"%ld分钟",(long)user.phone_minute];
    NSString *urlString = [NSString stringWithFormat:AdPictUrl,user.city,2];
    [callhistoryservice loadAdverPicFromUrl:urlString inViewController:self];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
-(void)loadView
{
    [super loadView];
    [self.minutes setEnabled:NO];
    dic = [[NSDictionary alloc] init];
   
    page =1;
    callhistoryservice = [[CallHistoryService alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
       call = [[CallService alloc] init];
    [self addButton];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

-(void)addButton
{
    btnView= [[ButtonVIew alloc] initWithFrame:CGRectMake(0, height1-95, width, 300)];
    btnView.backgroundColor = [UIColor whiteColor];
    j = 0;
    NSArray *array1 = [NSArray arrayWithObjects:@"contact_book",@"call_menu_up", nil];
    self.phone = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, width-8, 40)];
    self.phone.font = [UIFont systemFontOfSize:20];
    [self.phone setEnabled:NO];
    [btnView addSubview:self.phone];
    for (int k=0; k<2; k++) {
        btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(k*40,0, 40 , 40);
        btn2.tag = k;
        [btn2 setImage:[UIImage imageNamed:array1[k]] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(load:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn2];
    }
         NSArray *array = [NSArray arrayWithObjects:@"phone_call",@"bg_keyboard0@2x",@"delete",@"bg_keyboard7@2x",@"bg_keyboard8@2x",@"bg_keyboard9@2x",@"bg_keyboard4@2x",@"bg_keyboard5@2x",@"bg_keyboard6@2x",@"bg_keyboard1@2x",@"bg_keyboard2@2x",@"bg_keyboard3@2x", nil];
    for (int i=0; i<array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn.layer setBorderWidth:0.5];
        [btn.layer setBorderColor:[[UIColor grayColor] CGColor]];
        [btn setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(NUmber:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        columnCount = 3;
        CGFloat appW=90.0;
        CGFloat appH=50.0;
        CGFloat appMargin=(width-columnCount*appW)/(columnCount+1);
        //计算列号和行号
        int colX=i%columnCount;
        int rowY=i/columnCount;
        //计算坐标
        CGFloat appX = appMargin+colX*(appW+appMargin);
        CGFloat appY = 560 - appH*rowY-10;
        btn.frame = CGRectMake(appX, appY-350, appW, 40);
        [btnView addSubview:btn];
    }
    [self.view addSubview:btnView];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.datas.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CallHistoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallHistoryViewCell" forIndexPath:indexPath];
    Data_Info* model = self.datas[indexPath.section];
    cell.name.text = model.name;
    cell.time.text =[NSString stringWithFormat:@"%@分",model.minutes];
    cell.phone.text = model.phone;
    cell.regtime.text = model.regtime;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    dic = self.datas[indexPath.section];
    [self keyboardUp];
    self.phone.text = [dic valueForKey:@"phone"];
    
}

-(void)load:(UIButton *)sender
{
    if (sender.tag == 0) {
        ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
        picker.peoplePickerDelegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }else if(sender.tag == 1)
    {
        if(j ==0) {
            j =1;
            [self keyboardUp];
        } else {
            [self keyboardDown];
            j =0;
        }
        [self.view addSubview:btnView];
      
    }
}
-(void)keyboardUp{
    
    j=1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [btn2 setImage:[UIImage imageNamed:@"call_menu_downs"] forState:UIControlStateNormal];
    btnView.frame = CGRectMake(0, height1-btnView.frame.size.height,width, btnView.frame.size.height);
    [UIView commitAnimations];
}
-(void)keyboardDown
{
    j=0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.phone.text = @"";
    [btn2 setImage:[UIImage imageNamed:@"call_menu_up"] forState:UIControlStateNormal];
    btnView.frame= CGRectMake(0, height1-95, width, 300);
    [UIView commitAnimations];
}

-(void)NUmber:(UIButton *)sender
{
    
    NSInteger number =[sender tag];
    switch (number) {
        case 0:
            if (self.phone.text.length<3) {
                [SVProgressHUD showErrorWithStatus:@"请输入有效的电话号码"];
            }else {
                [call CallPhoneWithToken:user.token andUser_type:user.user_type AndPhone:self.phone.text intabBarController:self.tabBarController withdone:^(Phones_Info *model){
                    [SVProgressHUD showErrorWithStatus:@"转接成功请注意接听"];
                }];
            }
            break;
        case 1:
            self.self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,0];
            break;
        case 2:
            if (self.phone.text.length == 0) {
                self.phone.text =@" ";
            }
            self.phone.text = [self.phone.text stringByReplacingCharactersInRange:NSMakeRange(self.phone.text.length-1, 1) withString:@""];
            break;
        case 3:
            self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,7];
            break;
        case 4:
            self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,8];
            break;
        case 5:
            self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,9];
            break;
        case 6:
            self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,4];
            break;
        case 7:
            self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,5];
            break;
        case 8:
            self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,6];
            break;
        case 9:
            self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,1];
            break;
        case 10:
            self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,2];
            break;
        case 11:
            self.phone.text = [NSString stringWithFormat:@"%@%d",self.phone.text,3];
            break;
        default:
            break;
    }
    
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    ABMultiValueRef multiValue = ABRecordCopyValue(person,property);
    CFIndex index = ABMultiValueGetIndexForIdentifier(multiValue, identifier);
    NSString *phone1 = (__bridge NSString *)ABMultiValueCopyValueAtIndex(multiValue, index);
    self.phone.text = phone1;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    ABMultiValueRef multiValue = ABRecordCopyValue(person,property);
    CFIndex index = ABMultiValueGetIndexForIdentifier(multiValue, identifier);
    NSString *phone1 = (__bridge NSString *)ABMultiValueCopyValueAtIndex(multiValue, index);
    NSString *name = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *name1 =(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSLog(@"%@,%@",name,name1);
    //    [call CallPhoneWithMid:mid AndPhone:phone1 OnViewCOntroller:self];
    self.phone.text = phone1;
    [self keyboardUp];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}



-(void)headerRereshing
{
    page =1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [callhistoryservice call_historyWithToken:user.token andUser_type:user.user_type andPageString:pageString withDoneObject:^(Call_History_Info *model){
        self.datas =(NSMutableArray *)model.data;
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    }];
  
}
- (void)footerRereshing
{
    page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [callhistoryservice call_historyWithToken:user.token andUser_type:user.user_type andPageString:pageString withDoneObject:^(Call_History_Info *model){
       [self.datas addObjectsFromArray:model.data];
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma MartinLiPageScrollViewDelegate
-(void)imgViewDidTouchActionAtIndex:(NSInteger)index inArray:(NSArray *)array{
    NSString *url = array[index];
    if ([url  hasPrefix:@"http"]) {
        WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        target.urlString = url;
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }else{
        NSLog(@"第%ld张图片暂无url",(long)index);
    }
}
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"ToHelp"]) {
//        self.hidesBottomBarWhenPushed=YES;
//    }
//}
- (IBAction)qiandao:(id)sender {
    [call SiginWithToken:user.token andUser_Type:user.user_type intabBarController:self.tabBarController withdone:^(SiginIfo *model){
    self.minutes.text =[NSString stringWithFormat:@"%ld分钟",(long)model.minutes];
    }];

}
@end
