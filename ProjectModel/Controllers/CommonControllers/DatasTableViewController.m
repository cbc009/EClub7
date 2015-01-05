//
//  DatasTableViewController.m
//  Club
//
//  Created by dongway on 14-8-17.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "DatasTableViewController.h"

@interface DatasTableViewController ()
{
    NSArray *ids;
    NSArray *names;
    NSDictionary *dic;
    NSArray *array;
    NSDictionary *data;
}
@end

@implementation DatasTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    // Return the number of rows in the section.
    
    if (self.datas.count<3) {
        return array.count;
    }else{
        return self.datas.count;
    }
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
    if (self.datas.count<3) {
        data = [array objectAtIndex:row];
    }else{
        data = [self.datas objectAtIndex:row];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
            NSLog(@"%@",ids);
            break;
        case 2:
            array = [self.datas valueForKey:@"arrarea"];
            ids = [self propertiesByDatas:array withKey:@"area"];
            names = [self propertiesByDatas:array withKey:@"name"];
            NSLog(@"%@",ids);
            break;
        case 3:
            ids = [self propertiesByDatas:datas withKey:@"sid"];
            names = [self propertiesByDatas:datas withKey:@"name"];
            break;
        case 4:
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
