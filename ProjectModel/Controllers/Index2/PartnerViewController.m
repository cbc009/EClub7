//
//  PartnerViewController.m
//  Club
//
//  Created by MartinLi on 15-1-19.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PartnerViewController.h"

#import "LifehallCell.h"
#import "PartnerListServise.h"
#import "Partner_list_Model.h"
#import <UIImageView+WebCache.h>
@interface PartnerViewController ()
{
    PartnerListServise *partnerListServise;
    UserInfo *user;
}
@end

@implementation PartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合作商家";
    self.automaticallyAdjustsScrollViewInsets=YES;
    SharedData *sharedData = [SharedData sharedInstance];
    user = sharedData.user;
    partnerListServise = [[PartnerListServise alloc] init];
    [partnerListServise partnerPartnerListWithToken:user.token andUer_type:user.user_type andTabbarController:self.tabBarController withDone:^(Partner_list_Info *model){
        self.datas = (NSArray *)model.partner;
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
    Partner_Info *model = self.datas[indexPath.row];
    [Cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    Cell.name.text = model.name;
    return Cell;
}
#pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    Partner_Info *model = self.datas[row];
    [partnerListServise presentpartnerDetailwithToken:user.token andUser_type:user.user_type andPartner_id:model.partner_id inViewControllerOnViewController:self];
    
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
