//
//  Shoop_4Cell.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "Shoop_4Cell.h"
#import "Request_0Cell.h"
#import "NSString+MT.h"
#import "Seller_Seller_Comment.h"
@implementation Shoop_4Cell
{
    UITapGestureRecognizer *tapInview;//点赞区域

}
-(void)awakeFromNib {
//    self.tableview.autoresizesSubviews=NO;
    self.tableview.scrollEnabled=NO;
    self.datas=[NSMutableArray new];
    self.heardPic.layer.masksToBounds = YES;
    self.heardPic.layer.cornerRadius=20;
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tapInview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeInCell)];
    [self.tapView addGestureRecognizer:tapInview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    const CGFloat fontSize = 10;
    Sub_Comment_Info *model=self.datas[row];
    NSString *name2=model.regname;
    NSString *name3=model.other_name;
    NSString *string2 =model.content;
    NSUInteger length = [name2 length];
    NSUInteger length1=[name3 length];
    if ([model.other_name isEqualToString:@""]) {
        name2=[NSString stringWithFormat:@"%@: %@",name2,string2];
    }else{
        name2=[NSString stringWithFormat:@"%@回复了%@: %@",name2,name3,string2];
    }
    // 设置基本字体
    // 创建可变属性化字符串
    NSMutableAttributedString *attrString =[[NSMutableAttributedString alloc] initWithString:name2];
    UIFont *baseFont = [UIFont systemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:baseFont
                       range:NSMakeRange(0, length)];
    
    UIColor *color = [UIColor grayColor];
    [attrString addAttribute:(id)NSForegroundColorAttributeName
                       value:color
                       range:NSMakeRange(0, length)];
    
    [attrString addAttribute:(id)NSForegroundColorAttributeName
                       value:color
                       range:NSMakeRange(length+3, length1)];

    Request_0Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Request_0Cell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.detaillabel.attributedText=attrString;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    Sub_Comment_Info *model=self.datas[row];
     NSString *name=model.regname;
     NSString *name1=model.other_name;
     NSString *string =model.content;
    if ([model.other_name isEqualToString:@""]) {
        name=[NSString stringWithFormat:@"%@: %@",name,string];
    }else{
        name=[NSString stringWithFormat:@"%@回复了%@: %@",name,name1,string];
    }
    
    
    return  [NSString  heightWithString:name font:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(DeviceFrame.size.width-64, 200)];
   
    
}
- (IBAction)remark:(id)sender {
    [self.delegate remarkWithSender:sender inCell:self];
}
-(void)likeInCell{
    [self.delegate likeWithTapViewInCell:self];
}
- (IBAction)like:(id)sender {
    
    [self.delegate likeWithSender:sender inCell:self];
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    Sub_Comment_Info *model=self.datas[row];
    [self.delegate replyWithRegid:model.regid andRegName:model.regname andOtherName:model.regname inCell:self];
}
@end
