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
#import "Member_Login.h"
#import "BackGroundCell.h"
#import "BodyCell.h"
#import "LiveModel.h"
#import "LiveData.h"
#import <UIImageView+WebCache.h>
#import "MJRefresh.h"
#import <SVProgressHUD.h>
#import "MLMutiImagesChoosenViewController.h"
#import "Status.h"
#import "LifecircleService.h"
#import "PeopleDetailViewController.h"
#import "DAKeyboardControl.h"
#import "NSString+MT.h"
@interface LiveViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    LiveService *liveService;
    LifecircleService *lifecircleService;
    MLMutiImagesChoosenViewController *mutiImagesContoller;
    UserInfo *user;
    NSInteger h;
    NSInteger label_height;
   
    DataInfo *requestModel;
    NSInteger page;
    BodyCell *selectedCellForCommemt;
    UITapGestureRecognizer *tap;
    BackGroundCell *backCell;
    NSString *heardPicture;
    NSString *lifeBackPicture;
    NSInteger number;//这是1头像那一行
  
}
@property(nonatomic,strong)UIToolbar *toolBar;
@property(nonatomic,strong)UITextView *mytextView;
@property(nonatomic,strong)UIButton *sendButton;
//@property(nonatomic,strong)UITextField *textField;
@end

@implementation LiveViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [backCell.moveTimer invalidate];
    [self.view removeKeyboardControl];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    number=0;
    [SharedAction setupRefreshWithTableView:self.tableview toTarget:self];
    [self.tableview headerBeginRefreshing];
    self.title=@"生活圈";
    liveService = [[LiveService alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableview headerEndRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return  number;
    }else{
        return self.datas.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        BackGroundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackGroundCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        backCell=cell;
        [cell.herad sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,user.picture]] placeholderImage:[UIImage imageNamed:@"headss.png"]];
        cell.herad.userInteractionEnabled =YES;
        UITapGestureRecognizer *chageHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChangeHeard)];
        [cell.herad addGestureRecognizer:chageHead];
        cell.herad.layer.masksToBounds = YES;
        cell.herad.layer.cornerRadius = 30;
        cell.imageName=user.life_picture;
        cell.backView.userInteractionEnabled =YES;
        UITapGestureRecognizer *chageBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tpaChangebackGround)];
        [cell.backView addGestureRecognizer:chageBack];
        return cell;
    }else{
        static NSString *CellIdentifier =@"BodyCell";
        BodyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (cell==nil) {
            cell = [[BodyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        DataInfo *model = self.datas[indexPath.row];
        cell.nickname.text=model.nickname;
        cell.comment.text = model.content;
        cell.time.text = model.regtime;
        cell.delegate=self;
        cell.data =(NSMutableArray *)model.comment;
        cell.xid = model.xid;
        NSString *mid= [NSString stringWithFormat:@"%ld",(long)user.mid];
        if ( [model.mid isEqualToString:mid]) {
            cell.deleteContent.hidden=NO;
        }else{
            cell.deleteContent.hidden=YES;
        }
        cell.lableHeight.constant =[NSString heightWithString:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-84-7, 600)];
//        cell.tableFarm.constant = 8;
        cell.herad.layer.masksToBounds = YES;
        cell.herad.layer.cornerRadius = 30;
        [cell.herad sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.headpic]] placeholderImage:[UIImage imageNamed:@"headss.png"]];
        if (model.picture.count>0) {
            cell.collectionviewHeight.constant=64;
        }else{
            cell.collectionviewHeight.constant=0;
        }
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MLMutiImagesViewController" bundle:nil];
        mutiImagesContoller = [storyboard instantiateViewControllerWithIdentifier:@"MLMutiImagesChoosenViewController"];
        mutiImagesContoller.fatherController = self;
        mutiImagesContoller.imageMode = browseImagesMode;//（必选）
        mutiImagesContoller.imageUrls = [self imgUrlsFromTopic:model];
        mutiImagesContoller.superView = cell.collectionview;
        mutiImagesContoller.collectionviewHeight = cell.collectionviewHeight.constant;
        [self addChildViewController:mutiImagesContoller];
        [cell.collectionview addSubview: mutiImagesContoller.collectionView];
        [cell.tableview reloadData];
        return cell;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSArray *)imgUrlsFromTopic:(DataInfo *)object{
    NSString *urlString;
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (int i=0; i<object.picture.count; i++) {
        Picture_Info *info=object.picture[i];
       
        urlString = [NSString stringWithFormat:@"%@%@",IP,info.picture];
        [array addObject:urlString];
    }
    return array;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
         return 156;
    }else{
        CGFloat tableViewheight = 0.0;
        CGFloat topic_height = 0.0;
        CGFloat pictureHeight =0.0;
        DataInfo *dataInfo = self.datas[indexPath.row];
        topic_height = [NSString heightWithString:dataInfo.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-(84), 600)];
        if (dataInfo.picture.count>0) {
            pictureHeight =64;
        }else{
            pictureHeight =0;
        }
        if (dataInfo.comment.count==0){
            tableViewheight = 5;
        }else {
            CGFloat cellHeight = 0.0;
            CGFloat labelHeight = 0.0;
            for (int k=0; k<dataInfo.comment.count; k++) {
                CommentInfo *object = dataInfo.comment[k];
                labelHeight = [NSString heightWithString:object.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-84-7, 600)]+20;
                cellHeight =cellHeight+labelHeight;
            }
            tableViewheight = tableViewheight+cellHeight;
        }
        return topic_height+75+tableViewheight+pictureHeight;
    }
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    page = 1;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [SVProgressHUD show];
    [liveService loadLiveDataWithAgent_id:user.agent_id andPageString:pageString withTabBarViewController:self.tabBarController doneObject:^(LiveModelInfo *model1){
        self.datas = (NSMutableArray *)model1.data;
        heardPicture=model1.headpic;
        lifeBackPicture=model1.life_picture;
        [liveService countSizeWithData: self.datas inViewController:self];
        number=1;
        [self.tableview headerEndRefreshing];
        
        [self.tableview reloadData];
    }];
}

- (void)footerRereshing
{
    page++;
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
    [SVProgressHUD show];
    [liveService loadLiveDataWithAgent_id:user.agent_id andPageString:pageString withTabBarViewController:self.tabBarController doneObject:^(LiveModelInfo *model1){
        [self.datas addObjectsFromArray:model1.data];
        [liveService countSizeWithData:self.datas inViewController:self];
        [self.tableview footerEndRefreshing];
         [self.tableview reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//评论
#pragma BodyTableViewCellDelegate
-(void)request:(id)sender InCell:(BodyCell *)cell{
    //再次弹出键盘来之前先移除之前的键盘防止对象不消失一直存在
    if (self.mytextView!=nil) {
        [self handleAfterKeyboardHidden];
        [self.view removeKeyboardControl];
    }
    [self setupTextSendKeyboard];
    [self handleAfterKeyboardShown];
     NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    [self.tableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
   
    requestModel = self.datas[indexpath.row];
    NSLog(@"indexpath:%ld,model:%@",(long)indexpath.row,requestModel);
    selectedCellForCommemt = cell;
    NSLog(@"indexpath:%ld",(long)indexpath.row);
}

//删除按钮
-(void)delet:(id)sender InCell:(BodyCell *)cell
{
   NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    requestModel = self.datas[indexpath.row];
    LifecircleService *lifecircleServic = [[LifecircleService alloc] init];
    [lifecircleServic lifecircleLifedeleteWithToken:user.token andUser_type:user.user_type andXid:requestModel.xid withDone:^(Status *model2){
        if (model2.status==2) {
            [liveService deleteCellInLiveViewController:self atIndexPath:indexpath];
        }
    }];
}


-(void)someoneDetailInCell:(BodyCell *)cell
{
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    DataInfo *object = self.datas[indexpath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
    PeopleDetailViewController *peopleDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"PeopleDetailViewController"];
    peopleDetailViewController.hidesBottomBarWhenPushed = YES;
    peopleDetailViewController.model=object;
    [self.navigationController pushViewController:peopleDetailViewController animated:YES];
}
//修改背景图片
-(void)tpaChangebackGround
{
    if (user.user_type==1) {
        [SharedAction showErrorWithStatus:827 andError:@"需要注册以后才能使用该功能" witViewController:self.tabBarController];
    }else{
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"更换背景" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        action.tag=1;
        [action showInView:self.view.window];
    }
}
//修改头先暂时没用到
-(void)tapChangeHeard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Index2" bundle:nil];
    PeopleDetailViewController *peopleDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"PeopleDetailViewController"];
    peopleDetailViewController.hidesBottomBarWhenPushed = YES;
    DataInfo *object = [DataInfo new];
    object.mid = [NSString stringWithFormat:@"%ld",(long)user.mid];
    object.nickname = user.nickname;
    peopleDetailViewController.model = object;
    [self.navigationController pushViewController:peopleDetailViewController animated:YES];
}
//相机相关
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    if (buttonIndex==0) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }else if(buttonIndex==1){
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=nil;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    [liveService updateBackGroundImage:image inTabBarController:self.tabBarController withCompletion:^(NSDictionary *info){
        [picker dismissViewControllerAnimated:YES completion:^{
            NSString *picture = info[@"life_picture"];
            SharedData *sharedData = [SharedData sharedInstance];
            sharedData.user.life_picture = picture;
            [self.tableview reloadData];
        }];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [picker dismissViewControllerAnimated:YES completion:nil];
   
}
-(void)showImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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

    self.mytextView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    [self.toolBar addSubview:self.mytextView];
    
     self.sendButton= [UIButton buttonWithType:UIButtonTypeRoundedRect];
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
    NSLog(@"%@",self.mytextView.text);
    [self handleAfterKeyboardHidden];
    lifecircleService = [LifecircleService new];
    if (self.mytextView.text==nil||[self.mytextView.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
    }else{
        [lifecircleService lifecircleLifeCommentWithToken:user.token andUser_type:user.user_type andContent:self.mytextView.text andXid:requestModel.xid withTabBarController:self.tabBarController withDone:^(Status *model){
            CommentInfo *commentInfo = [CommentInfo new];
            commentInfo.content = self.mytextView.text;
            commentInfo.nickname = user.nickname;
            [selectedCellForCommemt.data addObject:commentInfo];
            NSArray *indexpaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:selectedCellForCommemt.data.count-1 inSection:0], nil];
            [selectedCellForCommemt.tableview insertRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationBottom];
            [selectedCellForCommemt.tableview reloadRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationBottom];            
            NSArray *this_indexpaths = [NSArray arrayWithObjects:[self.tableview indexPathForCell: selectedCellForCommemt], nil];
            [self.tableview reloadRowsAtIndexPaths:this_indexpaths withRowAnimation:UITableViewRowAnimationBottom];
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
