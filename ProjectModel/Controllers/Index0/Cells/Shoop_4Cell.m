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
    NSString *string;
    NSString *name;
    NSString *name1;

}
-(void)awakeFromNib {
//    self.tableview.autoresizesSubviews=NO;
    self.tableview.scrollEnabled=NO;
    self.datas=[NSMutableArray new];
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    Request_0Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Request_0Cell" forIndexPath:indexPath];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    const CGFloat fontSize = 9;
    Sub_Comment_Info *model=self.datas[row];
    name=model.regname;
    name1=model.other_name;
    
    string =model.content;
    // 创建可变属性化字符串
    NSUInteger length = [name length];
    NSUInteger length1=[name1 length];
    if (row==0) {
        name=[NSString stringWithFormat:@"%@:%@",name,string];
    }else{
        name=[NSString stringWithFormat:@"%@回复了%@:%@",name,name1,string];
    }
    // 设置基本字体
    NSMutableAttributedString *attrString =[[NSMutableAttributedString alloc] initWithString:name];
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
    
    cell.detaillabel.attributedText=attrString;
    cell.labelHeight.constant=[NSString  heightWithString:string font:[UIFont systemFontOfSize:9] maxSize:CGSizeMake(DeviceFrame.size.width-80, 200)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return  [NSString  heightWithString:name font:[UIFont systemFontOfSize:9] maxSize:CGSizeMake(DeviceFrame.size.width-80, 200)];
    
}
- (IBAction)remark:(id)sender {
    [self.delegate remarkWithSender:sender inCell:self];
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
