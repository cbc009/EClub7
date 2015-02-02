//
//  DatasTableViewController.m
//  Club
//
//  Created by dongway on 14-8-17.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "DatasTableViewController.h"
#import "ChooseAreaViewController.h"
@interface DatasTableViewController ()
{
    NSArray *ids;
    NSArray *names;
    NSDictionary *data;
}
@end

@implementation DatasTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView =[UIView new];
    [self propertiesByDatas:self.datas andIndex:self.index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [names objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    data = [self.datas objectAtIndex:row];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"data:%@",data);
    [self.delegate popViewControllerWithData:data andIndex:self.index];
}

-(void)propertiesByDatas:(NSArray *)datas andIndex:(NSInteger)index{
    switch (index) {
        case 0:
            ids = [self propertiesByDatas:datas withKey:@"province"];
            names = [self propertiesByDatas:datas withKey:@"name"];
            break;
        case 1:
            ids = [self propertiesByDatas:datas withKey:@"city"];
            names = [self propertiesByDatas:datas withKey:@"name"];
            break;
        case 2:
            ids = [self propertiesByDatas:datas withKey:@"lifehall_id"];
            names = [self propertiesByDatas:datas withKey:@"name"];
            break;
            
        default:
            break;
    }
    
}

-(NSArray *)propertiesByDatas:(NSArray *)datas withKey:(NSString *)key{
    NSMutableArray *identifies = [[NSMutableArray alloc] init];
    NSInteger length = datas.count;
    for (int i=0; i<length; i++) {
        NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:[datas objectAtIndex:i]];
        NSString *id = [dic objectForKey:key];
        [identifies addObject:id];
    }
    return identifies;
}

@end
