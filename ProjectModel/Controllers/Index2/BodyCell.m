//
//  BodyCell.m
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "BodyCell.h"
#import "RequestCell.h"
#import "LiveModel.h"
#import "LifecircleService.h"
#import "Status.h"
#import "NSString+MT.h"
@implementation BodyCell
{
    NSInteger h;
    UserInfo *user;
}
- (void)awakeFromNib {
    self.tableview.scrollEnabled =NO;
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
   
    self.herad.userInteractionEnabled =YES;
    UITapGestureRecognizer *chageBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSomeDetail)];
    [self.herad addGestureRecognizer:chageBack];

//    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Configure the view for the selected state
}
-(void)setCellContent:(LiveData *)data
{
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier =@"RequestCell";
    RequestCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    CommentInfo *model = self.data[indexPath.row];
    cell.name.text = model.nickname;
    cell.content.text = model.content;
//    NSLog(@"cell.content.frame:%@",NSStringFromCGRect(cell.content.frame));
//    NSLog(@"[UIScreen mainScreen].bounds.size.width-84-7:%f",[UIScreen mainScreen].bounds.size.width-84-7);

    cell.lableHeight.constant = [NSString heightWithString:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-84-7, 600)];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentInfo *model = self.data[indexPath.row];
    CGFloat cellHeight=0.0;
    cellHeight = [NSString heightWithString:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-84-7, 600)]+20;
 
    return cellHeight;
}
- (IBAction)request:(id)sender {
    [self.delegate request:sender InCell:self];
}

- (IBAction)delet:(id)sender {
     [self.delegate delet:sender InCell:self];
}
//修改背景图片
-(void)goSomeDetail
{
    [self.delegate someoneDetailInCell:self];
}

//-(void)request:(id)sender InCell:(UITableViewCell *)cell;
//-(void)delet:(id)sender InCell:(UITableViewCell *)cell
//{
//    NSLog(@"dd");
//    LifecircleService *lifecircleService = [[LifecircleService alloc] init];
//    [lifecircleService LifecircleLifedeleteWithToken:user.token andUser_type:user.user_type andXid:self.xid withDone:^(Status *model){
//        
//    }];
//
//}

@end
