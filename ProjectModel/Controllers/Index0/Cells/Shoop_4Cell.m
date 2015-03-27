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
@implementation Shoop_4Cell
{
    NSString *string;
    NSString *name;
}
-(void)awakeFromNib {
//    self.tableview.autoresizesSubviews=NO;
    self.tableview.scrollEnabled=NO;
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Request_0Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"Request_0Cell" forIndexPath:indexPath];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    const CGFloat fontSize = 10.0;
    name=@"世如个个";
    string =@"请问那个tableview是怎么弄成那样圆角的？我的数据存到了数据库中了，但是页面没有显示啊～搜索功... ";
    // 创建可变属性化字符串
    NSUInteger length = [name length];
    name=[NSString stringWithFormat:@"%@:%@",name,string];
    // 设置基本字体
    NSMutableAttributedString *attrString =[[NSMutableAttributedString alloc] initWithString:name];
    UIFont *baseFont = [UIFont systemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:baseFont
                       range:NSMakeRange(0, length)];

    UIColor *color = [UIColor grayColor];
    [attrString addAttribute:(id)NSForegroundColorAttributeName
                       value:color
                       range:NSMakeRange(0, length)];
    cell.detaillabel.attributedText=attrString;
    cell.labelHeight.constant=[NSString  heightWithString:string font:[UIFont systemFontOfSize:10.0] maxSize:CGSizeMake(DeviceFrame.size.width-80, 200)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return  [NSString  heightWithString:name font:[UIFont systemFontOfSize:10.0] maxSize:CGSizeMake(DeviceFrame.size.width-80, 200)];
    
}
@end
