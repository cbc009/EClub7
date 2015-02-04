//
//  SomeoneContentViewController.m
//  Club
//
//  Created by MartinLi on 15-2-3.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "SomeoneContentViewController.h"
#import "SomeoneContentCell.h"
#import "SomeoneContentService.h"
#import "SomeoneContent.h"
#import <UIImageView+WebCache.h>
#import "NSString+MT.h"
#import "DAKeyboardControl.h"
#import "LifecircleService.h"
#import "Status.h"
@interface SomeoneContentViewController ()
{
    UserInfo *user;
    UITapGestureRecognizer *tap;
    DatasInfo *object1;
    SomeoneContentCell*selectContentCell;
    
}
@property(nonatomic,strong)UIToolbar *toolBar;
@property(nonatomic,strong)UITextField *textField;
@end

@implementation SomeoneContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView =[UIView new];
    self.tableView.scrollEnabled =NO;

    SomeoneContentService *someoneContentService =[[SomeoneContentService alloc] init];
    [someoneContentService lifecircleLifeInfoWithToken:user.token andXid:self.model.xid andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(SomeoneContentModelInfo *model){
        object1=model.data;
        [self.heardPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object1.headpic]] placeholderImage:[UIImage imageNamed:@"userIcon.jpg"]];
        self.nickName.text = object1.nickname;
        self.content.text=object1.content;
        self.contenHeight.constant =[NSString heightWithString:object1.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-92, 600)];
        self.regtime.text=object1.regtime;
        self.datas = (NSMutableArray *)object1.comment;
        [self.tableView reloadData];
    }];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view removeKeyboardControl];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier =@"SomeoneContentCell";
    SomeoneContentCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CommentsInfo *model = self.datas[indexPath.row];
    cell.nicekname.text=model.nickname;
    cell.time.text=model.regtime;
    cell.content.text = model.content;
    cell.contentHeight.constant =[NSString heightWithString:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-94, 600)];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tableViewheight = 0.0;
    for (int i=0; i<self.datas.count; i++) {
        CommentsInfo *model = self.datas[i];
        tableViewheight =tableViewheight +[NSString heightWithString:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-94, 600)]+48;
    }
    self.tableViewHeight.constant =tableViewheight;
    CommentsInfo *model = self.datas[indexPath.row];
    return [NSString heightWithString:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-94, 600)]+48;
}

- (IBAction)contenAction:(id)sender {
    [self setupTextSendKeyboard];
    [self handleAfterKeyboardShown];
}
-(void)setupTextSendKeyboard{
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                               self.view.bounds.size.height - 40.0f,
                                                               self.view.bounds.size.width,
                                                               40.0f)];
    self.toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    self.toolBar.hidden=YES;
    [self.view addSubview:self.toolBar];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f,
                                                                   6.0f,
                                                                   self.toolBar.bounds.size.width - 20.0f - 68.0f,
                                                                   30.0f)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.toolBar addSubview:self.textField];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    sendButton.frame = CGRectMake(self.toolBar.bounds.size.width - 68.0f,
                                  6.0f,
                                  58.0f,
                                  29.0f);
    [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar addSubview:sendButton];
    self.view.userInteractionEnabled = YES;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAfterKeyboardHidden)];
    [self.view addGestureRecognizer:tap];
    self.view.keyboardTriggerOffset = self.toolBar.bounds.size.height;
    __weak typeof(self) weakSelf = self;
    [self.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView) {
        CGRect toolBarFrame = weakSelf.toolBar.frame;
        toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
        weakSelf.toolBar.frame = toolBarFrame;
    }];
}

//点击“发送”，评论
-(void)sendAction:(UIButton *)sender{
    NSLog(@"%@",self.textField.text);
    [self handleAfterKeyboardHidden];
    LifecircleService*lifecircleService = [LifecircleService new];
    if (self.textField.text==nil||[self.textField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
    }else{
        [lifecircleService lifecircleLifeCommentWithToken:user.token andUser_type:user.user_type andContent:self.textField.text andXid:object1.xid withTabBarController:self.tabBarController withDone:^(Status *model){
            CommentInfo *commentInfo = [CommentInfo new];
            commentInfo.content = self.textField.text;
            commentInfo.nickname = user.nickname;
            [self.datas addObject:commentInfo];
            NSArray *indexpaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.datas.count-1 inSection:0], nil];
            [self.tableView insertRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationBottom];
            [self.tableView reloadRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationBottom];
            NSArray *this_indexpaths = [NSArray arrayWithObjects:[self.tableView indexPathForCell: selectContentCell], nil];
            [self.tableView reloadRowsAtIndexPaths:this_indexpaths withRowAnimation:UITableViewRowAnimationBottom];

            self.textField.text = @"";
            [self.view removeKeyboardControl];
        }];
    }
}

-(void)handleAfterKeyboardShown{
    [self.textField becomeFirstResponder];
    self.toolBar.hidden = NO;
}

-(void)handleAfterKeyboardHidden{
    [self.view removeGestureRecognizer:tap];
    [self.textField resignFirstResponder];
    self.toolBar.hidden = YES;
}

@end
