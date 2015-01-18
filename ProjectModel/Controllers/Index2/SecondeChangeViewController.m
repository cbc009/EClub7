//
//  SecondeChangeViewController.m
//  Club
//
//  Created by MartinLi on 14-12-21.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "SecondeChangeViewController.h"
#import "SecondItemCell.h"
#import "SecondeService.h"
#import "SharedData.h"
#import "Member_Login.h"
#import <UIImageView+WebCache.h>
#import "SecondeChange.h"
@interface SecondeChangeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSInteger page;
    SecondeService *secondService;
    UserInfo *user;
}
@end

@implementation SecondeChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    page =1;
//    SharedData *sharedData = [SharedData sharedInstance];
//    user = sharedData.user;
//    secondService = [[SecondeService alloc] init];
//    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
//    [secondService loadDataWithSid:user.sid andPage:pageString onSecondeChangeViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondItemCell" forIndexPath:indexPath];
    TransInfo *model = self.datas[indexPath.section];
    NSLog(@"%@",model);
    cell.name.text =model.title;
//    cell.
//    cell.content.text = model.name;
//    [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PrexImgPath,model.picture[0]]] placeholderImage:[UIImage imageNamed:@"e"]];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",PrexImgPath,model.picture[0]]);
//    cell.time.text = model.regtime;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*
 设置segmentedControl
 */
- (IBAction)segAction:(UISegmentedControl *)sender {
//    page = 1;
//    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)page];
//    if (sender.selectedSegmentIndex==1) {
//       
////        [secondService loadBuyDataWithSid:user.sid andPage:pageString onSecondeChangeViewController:self];
//
//    }else{
////        [secondService loadDataWithSid:user.sid andPage:pageString onSecondeChangeViewController:self];
//    }
//    
}



@end
