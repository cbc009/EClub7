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
@implementation BodyCell
{
    NSInteger h;
    NSInteger label_height;
        int i;
}
- (void)awakeFromNib {
    // Initialization code
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
    self.tableview.scrollEnabled =NO;
    i++;
    NSLog(@"-----%@,**%d",self.data,i);
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"RequestCell";
    RequestCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[RequestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CommentInfo *model = self.data[indexPath.row];
    cell.name.text = model.nickname;
    cell.content.text = model.content;
    h  = cell.content.text.length/20;
    if (h==0) {
        label_height = 12;
    }else{
        label_height = h*12+20;
    }
    cell.content.backgroundColor = [UIColor yellowColor];
    cell.lableHeight.constant = label_height;
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return label_height+80;
}
@end
