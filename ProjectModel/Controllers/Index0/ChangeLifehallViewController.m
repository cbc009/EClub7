//
//  ChangeLifehallViewController.m
//  Club
//
//  Created by MartinLi on 15-3-11.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ChangeLifehallViewController.h"
#import "ChangeLifeService.h"
#import "Public_lifehall.h"
@interface ChangeLifehallViewController ()
{
    ChangeLifeService *changeLifeService;
    UserInfo *user;
    NSString *lifehallId;
    NSString *lifehallName;
}

@end

@implementation ChangeLifehallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SharedData *shredData = [SharedData sharedInstance];
    user =shredData.user;
    lifehallId=[NSString stringWithFormat:@"%ld",(long)user.lifehall_id];
    changeLifeService =[[ChangeLifeService alloc] init];
    __block ChangeLifehallViewController *blockSelf =self;
    [changeLifeService publiclifehallWithagentid:[NSString stringWithFormat:@"%ld",(long)user.agent_id] andLifehallId:[NSString stringWithFormat:@"%ld",(long)user.lifehall_id] inTabBarController:blockSelf.tabBarController withDone:^(Public_Lifehall_INfo *model){
        blockSelf.pickData =model.arr_lifehall;
        [self.changePick reloadAllComponents];
    }];
}

//-(void)loadRobuyDataWith
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (IBAction)changeAction:(id)sender {
    [self.delegate changeLifeId:lifehallId andLifeHallName:lifehallName];
    [self.view removeFromSuperview];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    Public_Lifehall_INfo_arr_lifehall *object =self.pickData[row];
    lifehallId=object.lifehall_id;
    user.lifehall_id=[lifehallId integerValue];
    lifehallName=object.lifehall_name;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickData count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    Public_Lifehall_INfo_arr_lifehall *object =self.pickData[row];
    return object.lifehall_name;
}

//-(NSString *)valueFromSelectedRows:(NSArray *)selectedRows andComponents:(NSArray *)components{
//
//}

- (NSInteger)numberOfRowsInComponent:(NSInteger)component{
    return self.pickData.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
