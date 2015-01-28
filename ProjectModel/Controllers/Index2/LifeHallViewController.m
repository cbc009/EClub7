//
//  LifeHallViewController.m
//  Club
//
//  Created by MartinLi on 15-1-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "LifeHallViewController.h"
#import "LifehallCell.h"
#import "LifeHallService.h"
#import "LifehallModel.h"
#import <UIImageView+WebCache.h>
@interface LifeHallViewController ()
{
    LifeHallService *lifeHallService;
    UserInfo *user;
}
@end

@implementation LifeHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生活体验馆";
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    self.automaticallyAdjustsScrollViewInsets=YES;
    lifeHallService = [[LifeHallService alloc] init];
    [lifeHallService lifehalllifehalllistWithToken:user.token andUer_type:user.user_type andTabbarController:self.tabBarController withDone:^(LifeHall_List_Info *model){
        self.datas = (NSArray *)model.lifehall;
        [self.collectionView reloadData];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.datas.count;
  
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LifehallCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LifehallCell" forIndexPath:indexPath];
    Life_Hall_Info *model = self.datas[indexPath.row];
    [Cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    Cell.name.text = model.name;
        return Cell;
}
#pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     NSInteger row = indexPath.row;
    Life_Hall_Info *model = self.datas[row];
    [lifeHallService presentLifeHallDetailwithToken:user.token andUser_type:user.user_type andLifeHall_id:model.lifehall_id inViewControllerOnViewController:self];
   
}
- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0  blue:238/255.0  alpha:1];
}
- (void)collectionView:(UICollectionView *)colView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}



@end
