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
#import "MLMutiImagesChoosenViewController.h"
@interface SomeoneContentViewController ()
{
    UserInfo *user;
    UITapGestureRecognizer *tap;
    DatasInfo *object1;
    SomeoneContentCell*selectContentCell;
    MLMutiImagesChoosenViewController *mutiImagesContoller;
    
}
@property(nonatomic,strong)UIToolbar *toolBar;
@property(nonatomic,strong)UITextView *mytextView;
@property(nonatomic,strong)UIButton *sendButton;

@end

@implementation SomeoneContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"详情";
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView =[UIView new];
    self.tableView.scrollEnabled =NO;

    SomeoneContentService *someoneContentService =[[SomeoneContentService alloc] init];
    [someoneContentService lifecircleLifeInfoWithToken:user.token andXid:self.model.xid andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(SomeoneContentModelInfo *model){
        object1=model.data;
        [self.heardPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,object1.headpic]] placeholderImage:[UIImage imageNamed:@"headss.png"]];
        self.nickName.text = object1.nickname;
        self.content.text=object1.content;
        self.contenHeight.constant =[NSString heightWithString:object1.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-92, 600)];
        self.regtime.text=object1.regtime;
        self.datas = (NSMutableArray *)object1.comment;
        if (object1.picture.count==0) {
            self.collectoonHeight.constant=0;
            self.collectionView.hidden=YES;
        }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MLMutiImagesViewController" bundle:nil];
        mutiImagesContoller = [storyboard instantiateViewControllerWithIdentifier:@"MLMutiImagesChoosenViewController"];
        mutiImagesContoller.fatherController = self;
        mutiImagesContoller.imageMode = browseImagesMode;//（必选）
        mutiImagesContoller.imageUrls = [self imgUrlsFromTopic:object1];
        mutiImagesContoller.superView = self.collectionView;
        mutiImagesContoller.collectionviewHeight = self.collectoonHeight.constant;
        [self addChildViewController:mutiImagesContoller];
        [self.collectionView addSubview: mutiImagesContoller.collectionView];
        }
        [self.tableView reloadData];
    }];
}
-(NSArray *)imgUrlsFromTopic:(DatasInfo *)object2{
    NSString *urlString;
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (int i=0; i<object2.picture.count; i++) {
        Picture_Info *info=object2.picture[i];
        urlString = [NSString stringWithFormat:@"%@%@",IP,info.picture];
        [array addObject:urlString];
    }
    return array;
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
    
    self.mytextView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f,
                                                                   6.0f,
                                                                   self.toolBar.bounds.size.width - 20.0f - 68.0f,
                                                                   30.0f)];

    self.mytextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    [self.toolBar addSubview:self.mytextView];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.sendButton.backgroundColor=[UIColor redColor];
    self.sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButton.frame = CGRectMake(self.toolBar.bounds.size.width - 68.0f,
                                  6.0f,
                                  58.0f,
                                  29.0f);
    [self.sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar addSubview:self.sendButton];
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
- (void)textDidChanged:(NSNotification *)notif //监听文字改变 换行时要更改输入框的位置
{
    CGSize contentSize = self.mytextView.contentSize;
    if (contentSize.height > 70){
        return;
    }
    CGFloat topic_height = [NSString heightWithString:self.mytextView.text font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(self.toolBar.bounds.size.width - 20.0f - 68.0f, 60)];
    self.toolBar.frame=CGRectMake(0.0f,
                                  self.view.bounds.size.height - 275.0f-topic_height,
                                  self.view.bounds.size.width,
                                  topic_height+12.7+12);
    self.sendButton.frame = CGRectMake(self.toolBar.bounds.size.width - 68.0f,
                                       6.0f,
                                       58.0f,
                                       12+topic_height);
}
//点击“发送”，评论
-(void)sendAction:(UIButton *)sender{
    [self handleAfterKeyboardHidden];
    LifecircleService*lifecircleService = [LifecircleService new];
    if (self.mytextView.text==nil||[self.mytextView.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
    }else{
        [lifecircleService lifecircleLifeCommentWithToken:user.token andUser_type:user.user_type andContent:self.mytextView.text andXid:object1.xid withTabBarController:self.tabBarController withDone:^(Status *model){
            CommentInfo *commentInfo = [CommentInfo new];
            commentInfo.content = self.mytextView.text;
            NSDate *currenTime = [NSDate date];
            commentInfo.nickname = user.nickname;
            commentInfo.regtime =[NSString dateStringFromDate1:currenTime];
            [self.datas addObject:commentInfo];
            NSArray *indexpaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.datas.count-1 inSection:0], nil];
            [self.tableView insertRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationBottom];
            [self.tableView reloadRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationBottom];
            NSArray *this_indexpaths = [NSArray arrayWithObjects:[self.tableView indexPathForCell: selectContentCell], nil];
            [self.tableView reloadRowsAtIndexPaths:this_indexpaths withRowAnimation:UITableViewRowAnimationBottom];

            self.mytextView.text = @"";
            [self.view removeKeyboardControl];
        }];
    }
}

-(void)handleAfterKeyboardShown{
    [self.mytextView becomeFirstResponder];
    self.toolBar.hidden = NO;
}

-(void)handleAfterKeyboardHidden{
    [self.view removeGestureRecognizer:tap];
    [self.mytextView resignFirstResponder];
    self.toolBar.hidden = YES;
}

@end
