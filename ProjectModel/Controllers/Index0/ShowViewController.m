//
//  ShowViewController.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShowViewController.h"
#import "ShowDetailViewController.h"
#import "ShoopGoodsViewController.h"
#import <UIImageView+WebCache.h>
#import "RemarkViewController.h"
 #import "Seller_Seller_Goods.h"
#import "Seller_Seller_Comment.h"
#import "DAKeyboardControl.h"
#import "Status.h"
#import "RemarkService.h"
#import "NSString+MT.h"
#import "SellerService.h"
#import "Shoop_0Cell.h"
#import "Shoop_1Cell.h"
#import "Shoop_2Cell.h"
#import "Shoop_3Cell.h"
#import "Shoop_4Cell.h"
#import "Index0_Cell.h"
#import "RatingBar.h"
@interface ShowViewController ()<ShowMoreItemsCellDelegate,Shoop_3Delegate,Shoop4CellDelegate,Shoop0Delegate,UITextViewDelegate>
{
    NSString *identifer;
    UINib *nib;
    SellerService *sellerService;
    UserInfo *user;
     UITapGestureRecognizer *tap;
    RemarkService *remarkService;
    Shoop_4Cell *selectCell;
    NSInteger type;//这个就是发送评论的类型
    NSString *oTherid;
    NSString *otherNames;
    NSString *regNames;
    RatingBar *ratingbar;
    NSArray *startArray;
    NSArray *titleArray;
    NSInteger keyBoardDown;//控制那个评价是否显示0消失 1显示
    UIView *ratingBarView;
    UITapGestureRecognizer *tap1;//隐藏ratingBarView
    Shoop_1Cell *shoopCell;
}
@property(nonatomic,strong)UIToolbar *toolBar;
@property(nonatomic,strong)UITextView *mytextView;
@property(nonatomic,strong)UIButton *sendButton;
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    keyBoardDown=0;
    sellerService =[SellerService new];
    remarkService =[RemarkService new];
    startArray= @[[NSString stringWithFormat:@"%ld",(long)(self.models.total_praises)],[NSString stringWithFormat:@"%ld",(long)(self.models.attitude_praises)],[NSString stringWithFormat:@"%ld",(long)(self.models.neat_praises)],[NSString stringWithFormat:@"%ld",(long)(self.models.descrip_praises)]];
    titleArray=@[@"总体:",@"服务态度:",@"店内环境:",@"描述相符:"];
    
    [sellerService sellerSellerCommentInfoWithSeller_id:self.models.seller_id andPageString:@"1" inTabBarController:self.tabBarController withDone:^(Seller_Seller_Comment_info *object){
        self.datas=object.arr_comment;
        [self.tablewView reloadData];
        [sellerService sellerSellerGood_typesWith:@"1" andSeller_id:self.models.seller_id andLifehall_id:[NSString stringWithFormat:@"%ld",(long)user.lifehall_id] andPage:@"1" inTabBarController:self.tabBarController withDone:^(Seller_Seller_Goods_info*model){
            shoopCell.datas=model.arr_goods;
            [shoopCell.collection reloadData];
        }];
    }];

    [self setRatingBarView];
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 1;
            break;
        case 5:
            return self.datas.count;
            break;
        default:
            break;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section=indexPath.section;
    NSInteger row =indexPath.row;
    CGFloat topicHeight;
     Seller_Seller_Comment_arr_comment_info *model =self.datas[row];
    topicHeight=0;
    switch (section) {
        case 0:
            return 93;
            break;
        case 1:
            return 136;
            break;
        case 2:
            return 41;
            break;
        case 3:
            if (row==0) {
                return 39;
            }else{
                return [NSString heightWithString:self.models.intro font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-16, 300)]+10;
            }
            break;
        case 5:
            topicHeight=[NSString heightWithString:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-80, 300)]+50;
            for (int i=0; i<model.sub_comment.count; i++) {
                if (model.sub_comment.count<2) {
                    Sub_Comment_Info *object=model.sub_comment[0];
                    topicHeight =topicHeight+[NSString heightWithString:[NSString stringWithFormat:@"%@: %@",object.content,object.regname] font:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(DeviceFrame.size.width-80, 300)]+2;
                }else{
                Sub_Comment_Info *object=model.sub_comment[i];
                topicHeight =topicHeight+[NSString heightWithString:[NSString stringWithFormat:@"%@回复了: %@%@",object.content,object.regname,object.other_name] font:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(DeviceFrame.size.width-80, 300)]+2;
                }
            }
            return topicHeight;
            break;
        case 4:
            return 33;
            break;

        default:
            break;
    }
    return 105;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section=indexPath.section;
    NSInteger row =indexPath.row;
    if (section==0) {
        Shoop_0Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_0Cell" forIndexPath:indexPath];
       cell.sellerName.text=self.models.seller_name;
       [cell.picture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.models.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        cell.totle.text=[NSString stringWithFormat:@"%ld分",(long)self.models.total_praises];
        RatingBar*bar = [[RatingBar alloc] initWithFrame:CGRectMake(65, 50,100, 20)];
        bar.starNumber=self.models.total_praises;
        bar.enable=NO;
        cell.delegate=self;
        [cell addSubview:bar];
        bar.frame=CGRectMake(cell.frame.origin.x+125,55,100, 20);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
         return cell;
    }else if(section==1){
        Shoop_1Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_1Cell" forIndexPath:indexPath];
        shoopCell=cell;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else if (section==3){
        Index0_Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Index0_Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.title.text=@"简介";
        }else{
            cell.title.text=self.models.intro;
            cell.topicHeight.constant=[NSString heightWithString:self.models.intro font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-64, 300)];
        }
        return cell;
    }else if (section==2){
        Shoop_2Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_2Cell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (row==0) {
            cell.phonePic.image=[UIImage imageNamed:@"phone"];
            cell.phone.text=self.models.phone;
        }else if(row==1){
            cell.phonePic.image=[UIImage imageNamed:@"time"];
            cell.phone.text=self.models.work_time;
        }else{
            cell.phonePic.image=[UIImage imageNamed:@"place"];
            cell.phone.text=self.models.address;
            cell.phone.font=[UIFont systemFontOfSize:12];
        }
        return cell;
    }else if(section==4){
            Shoop_3Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_3Cell" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.delegate=self;
            return cell;
    }else if(section==5){
            Shoop_4Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Shoop_4Cell" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            Seller_Seller_Comment_arr_comment_info *model =self.datas[row];
//            CGRect fram=cell.time.frame;
//            RatingBar*bar;
//            if ((bar=nil)) {
//                bar= [[RatingBar alloc] initWithFrame:CGRectMake(fram.origin.x-100, fram.origin.y+15,100, 20)];
//            }
//            bar.starNumber=[model.total_praises integerValue]-1;
//            bar.enable=NO;
//            cell.delegate=self;
//            [cell addSubview:bar];
//            bar.frame=CGRectMake(fram.origin.x-100, fram.origin.y+15,100, 20);
            cell.delegate=self;
            [cell.heardPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.models.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
            cell.topicHeight.constant=[NSString heightWithString:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-80, 300)];
            cell.nickName.text=model.regname;
            cell.content.text=model.content;
            cell.number.text=model.praise_nums;
            cell.time.text=model.regtime;
            cell.datas=(NSMutableArray*)model.sub_comment;
            [cell.tableview reloadData];
            return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 8;
}
-(void)moreItmes:(id)sender InCell:(UITableViewCell *)cell{
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShowDetailViewController *ShowDetailVic=[storBoard instantiateViewControllerWithIdentifier:@"ShowDetailViewController"];
    ShowDetailVic.seller_id=self.models.seller_id;
    [self.navigationController pushViewController:ShowDetailVic animated:YES];
}
-(void)pushShoopsGoodVicIncell:(UITableViewCell *)cell andModel:(Seller_Seller_Goods_arr_goods_info *)model{
   
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    ShoopGoodsViewController *shoopGoodVic=[storBoard instantiateViewControllerWithIdentifier:@"ShoopGoodsViewController"];
    shoopGoodVic.models=model;
    [self.navigationController pushViewController:shoopGoodVic animated:YES];
}
-(void)pushRemarkWithsender:(id)sender inCell:(Shoop_3Cell*)cell{
    UIStoryboard *storBoard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    RemarkViewController *remarkVIC=[storBoard instantiateViewControllerWithIdentifier:@"RemarkViewController"];
    remarkVIC.models=self.models;
   [self.navigationController pushViewController:remarkVIC animated:YES];

}
-(void)likeWithSender:(id)sender inCell:(Shoop_4Cell*)cell{
    NSIndexPath *indexpath = [self.tablewView indexPathForCell:cell];
    Seller_Seller_Comment_arr_comment_info *object = self.datas[indexpath.row];
    [remarkService seller_comment_releaseWuthType:@"1" andSeller_id:self.models.seller_id andContent:@"" andPraise_nums:@"1" andComment_id:object.comment_id andOther_id:@"" andTotal_praises:@"" andAttitude_praises:@"" andNeat_praises:@"" andDescrip_praises:@"" andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(Status *model){
        NSInteger num = [cell.number.text integerValue];
        num++;
        cell.number.text=[NSString stringWithFormat:@"%ld",(long)num];
        object.praise_nums=cell.number.text;
//        [self.datas addObject:object];
//        [self.datas exchangeObjectAtIndex:self.datas.count-1 withObjectAtIndex:indexpath.row];
//        [self.datas removeObject:self.datas[self.datas.count-1]];
    }];
}

-(void)remarkWithSender:(id)sender inCell:(Shoop_4Cell*)cell{
    type=0;
    NSIndexPath *indexpath = [self.tablewView indexPathForCell:cell];
    Seller_Seller_Comment_arr_comment_info *model;
    [self.tablewView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    model = self.datas[indexpath.row];
    regNames=model.regname;
    NSLog(@"indexpath:%ld",(long)indexpath.row);
    selectCell=cell;
    //再次弹出键盘来之前先移除之前的键盘防止对象不消失一直存在
    if (self.mytextView!=nil) {
        [self handleAfterKeyboardHidden];
        [self.view removeKeyboardControl];
    }
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
    self.mytextView.text=[NSString stringWithFormat:@"回复%@:",regNames];
    self.mytextView.textColor=[UIColor grayColor];
    self.mytextView.delegate=self;
    
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
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.mytextView.text=@"";
    self.mytextView.textColor=[UIColor blackColor];
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
    NSString *types;
    NSString *Praise_nums;
    NSLog(@"%@",self.mytextView.text);
    NSIndexPath *indexpath = [self.tablewView indexPathForCell:selectCell];
    Seller_Seller_Comment_arr_comment_info *object = self.datas[indexpath.row];
    [self handleAfterKeyboardHidden];
    if (type==0) {
        types=@"2";
        Praise_nums=@"1";
        oTherid=@"0";
    }else{
        Praise_nums=@"0";
        types=@"3";
    }
    [remarkService seller_comment_releaseWuthType:types andSeller_id:self.models.seller_id andContent:self.mytextView.text andPraise_nums:Praise_nums andComment_id:object.comment_id andOther_id:oTherid andTotal_praises:@"" andAttitude_praises:@"" andNeat_praises:@"" andDescrip_praises:@"" andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController withDone:^(Status *model){
        Sub_Comment_Info *commentInfo = [Sub_Comment_Info new];
        commentInfo.content = self.mytextView.text;
        commentInfo.regname = user.nickname;
        commentInfo.regid=[NSString stringWithFormat:@"%ld",(long)user.mid];
        commentInfo.other_name=otherNames;
        
        [selectCell.datas addObject:commentInfo];
        NSArray *indexpaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:selectCell.datas.count-1 inSection:0], nil];
        [selectCell.tableview insertRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationBottom];
        [selectCell.tableview reloadRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationBottom];
        NSArray *this_indexpaths = [NSArray arrayWithObjects:[self.tablewView indexPathForCell: selectCell], nil];
        [self.tablewView reloadRowsAtIndexPaths:this_indexpaths withRowAnimation:UITableViewRowAnimationBottom];
        self.mytextView.text = @"";
        [self.view removeKeyboardControl];
    }];

}
-(void)downWithSender:(id)sender inCell:(Shoop_0Cell *)cell{
    if (keyBoardDown==1) {
        keyBoardDown=0;
        [ratingBarView removeFromSuperview];
    }else{
        keyBoardDown=1;
         [self.view addGestureRecognizer:tap1];
        [self.tablewView addSubview:ratingBarView];
    }
}
-(void)setRatingBarView{
    tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ratingBarViewHidden)];
    

    ratingBarView =[[UIView alloc] initWithFrame:CGRectMake(125, 95, 170, 100)];
    ratingBarView.backgroundColor=[UIColor whiteColor];
    ratingBarView.alpha=1;
//    ratingBarView.layer.backgroundColor=(__bridge CGColorRef)([UIColor grayColor]);
//    ratingBarView.layer.borderWidth=0.5;
    UILabel *title;
    UILabel *point;
    for (int i=0; i<4; i++) {
        ratingbar = [[RatingBar alloc] initWithFrame:CGRectMake(47, 15+20*i, 100, 20)];
        title=[[UILabel alloc] initWithFrame:CGRectMake(5, 15+20*i, 40, 20)];
        point =[[UILabel alloc] initWithFrame:CGRectMake(150, 15+20*i, 20, 20)];
        point.text=[NSString stringWithFormat:@"%@分",startArray[i]];
        [point setFont:[UIFont fontWithName:@"Helvetica" size:9.0]];
        title.backgroundColor=[UIColor whiteColor];
        title.text=titleArray[i];
        [title setFont:[UIFont fontWithName:@"Helvetica" size:9.0]];
        ratingbar.frame=CGRectMake(47, 15+20*i, 100, 20);
        ratingbar.tag=i;
        ratingbar.enable=NO;
        ratingbar.starNumber=[startArray[i] integerValue];
        [ratingBarView addSubview:ratingbar];
        [ratingBarView addSubview:title];
        [ratingBarView addSubview:point];
    }
}

-(void)ratingBarViewHidden{
    keyBoardDown=0;
    [self.view removeGestureRecognizer:tap1];
    [ratingBarView removeFromSuperview];
}
-(void)handleAfterKeyboardShown{
//    [self.mytextView becomeFirstResponder];
    self.toolBar.hidden = NO;
}

-(void)handleAfterKeyboardHidden{
    [self.view removeGestureRecognizer:tap];
    [self.mytextView resignFirstResponder];
    self.toolBar.hidden = YES;
}
-(void)replyWithRegid:(NSString *)regid andRegName:(NSString *)regName andOtherName:(NSString *)otherName inCell:(Shoop_4Cell*)cell{
    oTherid=regid;
    otherNames =otherName;
    regNames=regName;
     type=1;
    //再次弹出键盘来之前先移除之前的键盘防止对象不消失一直存在
    if (self.mytextView!=nil) {
        [self handleAfterKeyboardHidden];
        [self.view removeKeyboardControl];
    }
    [self setupTextSendKeyboard];
    [self handleAfterKeyboardShown];
    NSIndexPath *indexpath = [self.tablewView indexPathForCell:cell];
    Seller_Seller_Comment_arr_comment_info *model = self.datas[indexpath.row];
    [self.tablewView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    model = self.datas[indexpath.row];
    NSLog(@"indexpath:%ld",(long)indexpath.row);
    selectCell=cell;
}
@end
